import 'package:aura_maison_e_commerce/features/auth/data/models/verify_model.dart';
import 'package:dio/dio.dart';

class VerifyEmailService {
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

  Future<Response> verifyEmail(VerifyEmailModel model) async {
    try {
      return await dio.post('/auth/verify-email', data: model.toJson());
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(_extractMessage(e.response!.data));
      }

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Connection timed out. Please try again.');
      }

      throw Exception('Please check your internet connection.');
    }
  }

  String _extractMessage(dynamic data) {
    const fallback = 'Verification failed. Please try again.';

    if (data == null) return fallback;

    if (data is String) {
      return data.trim().isEmpty ? fallback : data;
    }

    if (data is Map) {
      final errors = data['errors'];

      // {errors: {email: ["..."], otp: ["..."]}}
      if (errors is Map) {
        final messages = errors.values
            .expand((v) => v is List ? v : [v])
            .map((e) => e.toString())
            .where((s) => s.isNotEmpty)
            .toList();
        if (messages.isNotEmpty) return messages.join('\n');
      }

      final message =
          data['message'] ?? data['title'] ?? data['detail'] ?? data['error'];
      if (message != null && message.toString().isNotEmpty) {
        return message.toString();
      }
    }

    return fallback;
  }
}
