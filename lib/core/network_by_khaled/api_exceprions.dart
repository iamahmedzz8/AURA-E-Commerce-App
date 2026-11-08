import 'package:aura_maison_e_commerce/core/network_by_khaled/api_error.dart';
import 'package:dio/dio.dart';

class ApiException {
  static ApiError handleError(DioException error) {

    final  statusCode=error.response?.statusCode;
    final data=error.response?.data;
    if (data is Map<String,dynamic>&& data["message"]!=null)
    {
      return ApiError(message: data["message"],statusCode: statusCode);
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(message: error.toString());
      case DioExceptionType.sendTimeout:
        return ApiError(message: error.toString());

      case DioExceptionType.receiveTimeout:
        return ApiError(message: error.toString());

      case DioExceptionType.badCertificate:
        return ApiError(message: error.toString());

      case DioExceptionType.badResponse:
        return ApiError(message: error.toString());

      case DioExceptionType.cancel:
        return ApiError(message: error.toString());

      case DioExceptionType.connectionError:
        return ApiError(message: error.toString());

      case DioExceptionType.unknown:
        return ApiError(message: error.toString());
      case DioExceptionType.transformTimeout:
        return ApiError(message: error.toString());
    }
  }
}
