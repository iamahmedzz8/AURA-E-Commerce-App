import 'dart:io';
import 'package:aura_maison_e_commerce/core/network/api_endpoints.dart';
import 'package:aura_maison_e_commerce/core/services/token_storage_service.dart';
import 'package:dio/dio.dart';

/// Interceptor that attaches the Bearer token to requests and manages
/// automatic token refresh when a 401 Unauthorized response occurs.
class AuthInterceptor extends QueuedInterceptor {
  final TokenStorageService _tokenStorage;
  final Dio _dio;

  AuthInterceptor({
    required TokenStorageService tokenStorage,
    required Dio dio,
  })  : _tokenStorage = tokenStorage,
        _dio = dio;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Avoid attaching Bearer token to login or refresh endpoints
    final isAuthEndpoint = options.path.contains('/api/auth/login') ||
        options.path.contains('/api/auth/refresh-token') ||
        options.path.contains('/api/auth/register');

    if (!isAuthEndpoint && !options.headers.containsKey('Authorization')) {
      final token = await _tokenStorage.getAccessToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    // Avoid sending Content-Type on GET requests without body to prevent ASP.NET JSON deserializer errors
    if (options.method.toUpperCase() == 'GET' && options.data == null) {
      options.headers.remove('Content-Type');
      options.contentType = null;
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = err.response?.statusCode;
    final isRefreshEndpoint =
        err.requestOptions.path.contains(ApiEndpoints.refreshToken);
    final isLoginEndpoint =
        err.requestOptions.path.contains(ApiEndpoints.login);

    if (isRefreshEndpoint && statusCode != null && statusCode >= 400) {
      await _tokenStorage.clearTokens();
      return handler.next(err);
    }

    // If 401 Unauthorized and not already refreshing or logging in
    if (statusCode == 401 && !isRefreshEndpoint && !isLoginEndpoint) {
      final refreshToken = await _tokenStorage.getRefreshToken();
      if (refreshToken != null && refreshToken.isNotEmpty) {
        try {
          // Attempt token refresh
          final refreshDio = Dio(
            BaseOptions(
              baseUrl: ApiEndpoints.baseUrl,
              connectTimeout: ApiEndpoints.connectTimeout,
              receiveTimeout: ApiEndpoints.receiveTimeout,
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
            ),
          );

          final refreshResponse = await refreshDio.post(
            ApiEndpoints.refreshToken,
            data: {
              'refreshToken': refreshToken,
              'useCookies': false,
            },
          );

          if (refreshResponse.statusCode == 200 &&
              refreshResponse.data != null) {
            final data = refreshResponse.data;
            final newAccessToken = data['accessToken'] as String?;
            final newRefreshToken =
                data['refreshToken'] as String? ?? refreshToken;
            final expiresAtStr = data['expiresAtUtc'] as String?;
            final expiresAt =
                expiresAtStr != null ? DateTime.tryParse(expiresAtStr) : null;

            if (newAccessToken != null) {
              await _tokenStorage.saveTokens(
                accessToken: newAccessToken,
                refreshToken: newRefreshToken,
                expiresAt: expiresAt,
              );

              // Retry the original request with the new access token
              final retryOptions = err.requestOptions;
              retryOptions.headers['Authorization'] = 'Bearer $newAccessToken';

              final retryResponse = await _dio.fetch(retryOptions);
              return handler.resolve(retryResponse);
            }
          }
        } catch (_) {
          // Token refresh failed - clear tokens so app handles unauthenticated state
          await _tokenStorage.clearTokens();
        }
      } else {
        await _tokenStorage.clearTokens();
      }
    }

    return handler.next(err);
  }
}

/// Standardized Exception model for Network & API Errors
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const ApiException({
    required this.message,
    this.statusCode,
    this.data,
  });

  @override
  String toString() =>
      'ApiException: $message ${statusCode != null ? '(Status: $statusCode)' : ''}';

  factory ApiException.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ApiException(
          message: 'Connection timed out. Please check your internet connection.',
          statusCode: 408,
        );

      case DioExceptionType.badResponse:
        final status = dioException.response?.statusCode;
        final responseData = dioException.response?.data;
        String errorMessage = 'Unexpected server response ($status).';

        if (responseData is Map && responseData.containsKey('message')) {
          errorMessage = responseData['message'].toString();
        } else if (responseData is Map && responseData.containsKey('title')) {
          errorMessage = responseData['title'].toString();
        } else if (responseData is String && responseData.isNotEmpty) {
          errorMessage = responseData;
        }

        switch (status) {
          case 400:
            return ApiException(
              message: errorMessage.isNotEmpty ? errorMessage : 'Bad request.',
              statusCode: 400,
              data: responseData,
            );
          case 401:
            return ApiException(
              message: 'Authentication session expired. Please sign in.',
              statusCode: 401,
              data: responseData,
            );
          case 403:
            return ApiException(
              message: 'Access forbidden. You do not have permission for this resource.',
              statusCode: 403,
              data: responseData,
            );
          case 404:
            return ApiException(
              message: errorMessage.isNotEmpty ? errorMessage : 'Requested resource not found.',
              statusCode: 404,
              data: responseData,
            );
          case 500:
          case 502:
          case 503:
            return const ApiException(
              message: 'Server error. Our atelier engineers are on it.',
              statusCode: 500,
            );
          default:
            return ApiException(
              message: errorMessage,
              statusCode: status,
              data: responseData,
            );
        }

      case DioExceptionType.connectionError:
        return const ApiException(
          message: 'Unable to connect to the server. Please check your network.',
        );

      case DioExceptionType.cancel:
        return const ApiException(
          message: 'Request was cancelled.',
        );

      case DioExceptionType.badCertificate:
        return const ApiException(
          message: 'Security certificate verification failed.',
        );

      case DioExceptionType.unknown:
      default:
        if (dioException.error is SocketException) {
          return const ApiException(
            message: 'No internet connection available.',
          );
        }
        return ApiException(
          message: dioException.message ?? 'An unexpected error occurred.',
        );
    }
  }
}
