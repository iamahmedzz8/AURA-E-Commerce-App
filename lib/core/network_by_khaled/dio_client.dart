import 'package:aura_maison_e_commerce/core/services/token_storage_service.dart';
import 'package:dio/dio.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(minutes: 1),
        receiveTimeout: const Duration(minutes: 1),
        baseUrl: 'https://accessories-eshop.runasp.net',
        receiveDataWhenStatusError: true,
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          try {
            final tokenStorage = TokenStorageService();
            final token = await tokenStorage.getAccessToken();
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          } catch (_) {}
          return handler.next(options);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
