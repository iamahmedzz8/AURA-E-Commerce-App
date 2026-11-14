import 'package:aura_maison_e_commerce/features/auth/data/models/register_model.dart';
import 'package:dio/dio.dart';

class RegisterService {
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

  Future<Response> signUp(RegisterModel model) async {
    try {
      return await dio.post('/auth/register', data: model.toJson());
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

  /// Turns any error body the server returns into a readable message.
  String _extractMessage(dynamic data) {
    const fallback = 'Registration failed. Please try again.';

    if (data == null) return fallback;

    if (data is String) {
      return data.trim().isEmpty ? fallback : data;
    }

    // Identity-style list: [{code: ..., description: ...}]
    if (data is List) {
      final messages = data
          .map((e) {
            if (e is Map) {
              return (e['description'] ?? e['message'] ?? e['code'] ?? '')
                  .toString();
            }
            return e.toString();
          })
          .where((s) => s.isNotEmpty)
          .toList();
      return messages.isEmpty ? fallback : messages.join('\n');
    }

    if (data is Map) {
      final errors = data['errors'];

      // Validation style: {errors: {Email: ["..."], Password: ["..."]}}
      if (errors is Map) {
        final messages = errors.values
            .expand((v) => v is List ? v : [v])
            .map((e) => e.toString())
            .where((s) => s.isNotEmpty)
            .toList();
        if (messages.isNotEmpty) return messages.join('\n');
      }

      if (errors is List) return _extractMessage(errors);

      final message =
          data['message'] ?? data['title'] ?? data['detail'] ?? data['error'];
      if (message != null && message.toString().isNotEmpty) {
        return message.toString();
      }
    }

    return fallback;
  }
}
