// core/errors/error_handler.dart
import 'package:aura_maison_e_commerce/core/error/failure.dart';
import 'package:dio/dio.dart';

class ErrorHandler implements Exception {
  final Failure failure;

  ErrorHandler.handle(dynamic error) : failure = _handleError(error);

  static Failure _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return DataSource.connectTimeout.getFailure();
        case DioExceptionType.sendTimeout:
          return DataSource.sendTimeout.getFailure();
        case DioExceptionType.receiveTimeout:
          return DataSource.receiveTimeout.getFailure();
        case DioExceptionType.badCertificate:
          return DataSource.customDefault.getFailure();
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          final responseData = error.response?.data;

          if (responseData is Map<String, dynamic>) {
            final message = responseData['message'];

            if (message is String && message.isNotEmpty) {
              final localizedMessage = _getLocalizedApiMessage(message);

              return Failure(
                code: statusCode ?? ResponseCode.customDefault,
                message: localizedMessage ?? message,
              );
            }
          }

          switch (statusCode) {
            case 400:
              return DataSource.badRequest.getFailure();

            case 401:
              return DataSource.unAuthorised.getFailure();

            case 403:
              return DataSource.forbidden.getFailure();

            case 404:
              return DataSource.notFound.getFailure();

            case 500:
              return DataSource.internalServerError.getFailure();

            default:
              return Failure(
                code: statusCode ?? ResponseCode.customDefault,
                message: ResponseMessage.customDefault,
              );
          }
        case DioExceptionType.cancel:
          return DataSource.cancel.getFailure();
        case DioExceptionType.connectionError:
          return DataSource.noInternetConnection.getFailure();
        case DioExceptionType.unknown:
          return DataSource.customDefault.getFailure();
        case DioExceptionType.transformTimeout:
          return DataSource.customDefault.getFailure();
      }
    } else {
      // Any other error (not Dio)
      if (error is String && error == 'Email not found') {
        return Failure(
          code: ResponseCode.customDefault,
          message: ResponseMessage.emailNotFound,
        );
      }
      return DataSource.customDefault.getFailure();
    }
  }

  static String? _getLocalizedApiMessage(String message) {
    if (message.startsWith('Invalid PhoneNumber Or Password')) {
      final match = RegExp(r'Failed attempts:\s*(\d+)').firstMatch(message);

      final attempts = match?.group(1) ?? '';

      return "Invalid PhoneNumber Or Password";
    }

    if (message.startsWith(
      'Your account has been locked due to multiple failed attempts',
    )) {
      return "Your account has been locked due to multiple failed attempts";
    }
    if (message.startsWith('Endpoint Not Found')) {
      return "An error occurred. Please try again later.";
    }

    if (message.startsWith('Account is locked until')) {
      final match = RegExp(
        r'Account is locked until (.+?)\. Use OTP to login\.',
      ).firstMatch(message);

      final lockedUntil = match?.group(1) ?? '';

      return "Account is locked";
    }

    return null;
  }
}

enum DataSource {
  noContent,
  badRequest,
  forbidden,
  unAuthorised,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  customDefault,
}

extension DataSuorceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.noContent:
        return Failure(
          code: ResponseCode.noContent,
          message: ResponseMessage.noContent,
        );
      case DataSource.badRequest:
        return Failure(
          code: ResponseCode.badRequest,
          message: ResponseMessage.badRequest,
        );
      case DataSource.forbidden:
        return Failure(
          code: ResponseCode.forbidden,
          message: ResponseMessage.forbidden,
        );
      case DataSource.unAuthorised:
        return Failure(
          code: ResponseCode.unAuthorised,
          message: ResponseMessage.unAuthorised,
        );
      case DataSource.notFound:
        return Failure(
          code: ResponseCode.notFound,
          message: ResponseMessage.notFound,
        );
      case DataSource.internalServerError:
        return Failure(
          code: ResponseCode.internalServerError,
          message: ResponseMessage.internalServerError,
        );
      case DataSource.connectTimeout:
        return Failure(
          code: ResponseCode.connectTimeout,
          message: ResponseMessage.connectTimeout,
        );
      case DataSource.cancel:
        return Failure(
          code: ResponseCode.cancel,
          message: ResponseMessage.cancel,
        );
      case DataSource.receiveTimeout:
        return Failure(
          code: ResponseCode.receiveTimeout,
          message: ResponseMessage.receiveTimeout,
        );
      case DataSource.sendTimeout:
        return Failure(
          code: ResponseCode.sendTimeout,
          message: ResponseMessage.sendTimeout,
        );
      case DataSource.cacheError:
        return Failure(
          code: ResponseCode.cacheError,
          message: ResponseMessage.cacheError,
        );
      case DataSource.noInternetConnection:
        return Failure(
          code: ResponseCode.noInternetConnection,
          message: ResponseMessage.noInternetConnection,
        );
      case DataSource.customDefault:
        return Failure(
          code: ResponseCode.customDefault,
          message: ResponseMessage.customDefault,
        );
    }
  }
}

class ResponseCode {
  static const int success = 200; // success with data
  static const int noContent = 201; // success with no data (no content)
  static const int badRequest = 400; // failure, API rejected request
  static const int unAuthorised = 401; // failure, user is not authorised
  static const int forbidden = 403; //  failure, API rejected request
  static const int notFound = 404; // failure , not found
  static const int internalServerError = 500; // failure, crash in server side

  // local status code
  static const int connectTimeout = -1; //
  static const int cancel = -2; //
  static const int receiveTimeout = -3; //
  static const int sendTimeout = -4; //
  static const int cacheError = -5; //
  static const int noInternetConnection = -6; //
  static const int customDefault = -7;
}

class ResponseMessage {
  static String success = "Success";

  // success with no data
  static String noContent = "No Content";

  // failure, API rejected request
  static String badRequest = "Bad Request";

  // failure, user is not authorised
  static String unAuthorised = "Unauthorised";

  // failure, API rejected request
  static String forbidden = "Forbidden";

  // failure, not found
  static String notFound = "Not Found";

  // failure, crash in server side
  static String internalServerError = "Internal Server Error";

  static String connectTimeout = "Connection Timeout";

  static String cancel = "Request Canceled";

  static String receiveTimeout = "Receive Timeout";

  static String sendTimeout = "Send Timeout";

  static String cacheError = "Cache Error";

  static String noInternetConnection = "No Internet Connection";

  static String customDefault = "Something went wrong";

  static String emailNotFound = "Email not found";
}

class ApiInternalStatus {
  static const int success = 1;
  static const int failure = 0;
}
