import 'dart:io';

import 'package:aura_maison_e_commerce/core/network_by_khaled/api_error.dart';
import 'package:dio/dio.dart';

class ApiException {
  static ApiError handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(
          message:
              'Connection timed out. Please check your internet and try again.',
        );
      case DioExceptionType.sendTimeout:
        return ApiError(
          message: 'Request timed out while sending data. Please try again.',
        );
      case DioExceptionType.receiveTimeout:
        return ApiError(
          message: 'The server took too long to respond. Please try again.',
        );
      case DioExceptionType.badCertificate:
        return ApiError(
          message: 'Secure connection failed. Please try again later.',
        );
      case DioExceptionType.cancel:
        return ApiError(message: 'The request was cancelled.');
      case DioExceptionType.connectionError:
        return ApiError(
          message:
              'No internet connection. Please check your network and try again.',
        );
      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);
      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return ApiError(
            message:
                'No internet connection. Please check your network and try again.',
          );
        }
        return ApiError(message: 'Something went wrong. Please try again.');
      case DioExceptionType.transformTimeout:
        return ApiError(message: 'Something went wrong. Please try again.');
    }
  }

  static ApiError _handleBadResponse(Response? response) {
    final code = response?.statusCode;

    // 5xx: always a friendly generic message
    if (code == 500) {
      return ApiError(
        message: 'Something went wrong on our side. Please try again later.',
        statusCode: code,
      );
    }
    if (code == 502 || code == 503 || code == 504) {
      return ApiError(
        message:
            'The server is temporarily unavailable. Please try again later.',
        statusCode: code,
      );
    }

    // 4xx: prefer the server message if there is one
    final serverMessage = _extractServerMessage(response?.data);
    if (serverMessage != null) {
      return ApiError(message: serverMessage, statusCode: code);
    }

    switch (code) {
      case 400:
        return ApiError(
          message: 'Invalid request. Please check your data and try again.',
          statusCode: code,
        );
      case 401:
        return ApiError(
          message: 'Your session has expired. Please log in again.',
          statusCode: code,
        );
      case 403:
        return ApiError(
          message: "You don't have permission to do this.",
          statusCode: code,
        );
      case 404:
        return ApiError(
          message: 'The requested data was not found.',
          statusCode: code,
        );
      case 409:
        return ApiError(
          message: 'This action conflicts with existing data.',
          statusCode: code,
        );
      case 422:
        return ApiError(
          message: 'Some of the entered data is invalid.',
          statusCode: code,
        );
      case 429:
        return ApiError(
          message: 'Too many requests. Please try again later.',
          statusCode: code,
        );
      default:
        return ApiError(
          message: 'Something went wrong. Please try again.',
          statusCode: code,
        );
    }
  }

  static String? _extractServerMessage(dynamic data) {
    if (data is Map) {
      final message = data['message'];
      if (message is String && message.trim().isNotEmpty) return message;

      final errors = data['errors'];
      if (errors is Map && errors.isNotEmpty) {
        final first = errors.values.first;
        if (first is List && first.isNotEmpty) return first.first.toString();
        return first.toString();
      }
      if (errors is List && errors.isNotEmpty) return errors.first.toString();

      final title = data['title'];
      if (title is String && title.trim().isNotEmpty) return title;
    }
    return null;
  }
}
