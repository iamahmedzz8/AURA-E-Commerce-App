import 'package:aura_maison_e_commerce/core/network/api_endpoints.dart';
import 'package:aura_maison_e_commerce/core/network/dio_client.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl({
    required this.dioClient,
  });

  @override
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await dioClient.post<Map<String, dynamic>>(
      ApiEndpoints.login,
      data: {
        'email': email.trim(),
        'password': password,
      },
    );

    final data = response.data;

    if (data == null) {
      throw Exception('Login response is empty.');
    }

    return data;
  }
}