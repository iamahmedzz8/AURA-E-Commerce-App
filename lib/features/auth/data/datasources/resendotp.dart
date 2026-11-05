import 'package:dio/dio.dart';

class ResendOtpService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://accessories-eshop.runasp.net/api',
      connectTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  Future<void> resend(String email) async {
    try {
      // TODO: غيّر الـ endpoint واسم الحقل حسب الـ Swagger
      await dio.post('/auth/resend-otp', data: {'email': email});
    } on DioException catch (e) {
      if (e.response != null) {
        final data = e.response!.data;
        if (data is Map && data['message'] != null) {
          throw Exception(data['message'].toString());
        }
        throw Exception('Failed to resend code.');
      }
      throw Exception('Please check your internet connection.');
    }
  }
}