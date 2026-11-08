import 'package:aura_maison_e_commerce/core/network_by_khaled/api_exceprions.dart';
import 'package:aura_maison_e_commerce/core/network_by_khaled/dio_client.dart';
import 'package:dio/dio.dart';

class ApiService {
  final DioClient _dioClient = DioClient();

  /// CRUD Methods

  /// get
  Future<dynamic> getData(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dioClient.dio.get(
        endPoint,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiException.handleError(e);
    }
  }

  /// post
  Future<dynamic> postData(String endPoint, dynamic data) async {
    try {
      final response = await _dioClient.dio.post(endPoint, data: data);
      return response.data;
    } on DioException catch (e) {
      throw ApiException.handleError(e);
    }
  }
}
