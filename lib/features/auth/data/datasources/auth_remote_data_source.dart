import 'package:aura_maison_e_commerce/core/network/api_endpoints.dart';
import 'package:aura_maison_e_commerce/core/network/dio_client.dart';

/// Contract for remote authentication operations.
/// Communicates directly with [DioClient] without intermediate repository abstractions.
abstract class AuthRemoteDataSource {
  /// Request a password reset OTP/link sent to the patron's email.
  Future<void> forgotPassword(String email);

  /// Resend a fresh OTP security code to the given email address.
  Future<void> resendOtp(String email);

  /// Verify email after registration using the 6-digit OTP code.
  Future<void> verifyEmail(String email, String otp);

  /// Validate password recovery OTP code before resetting password.
  Future<void> validateOtp(String email, String otp);

  /// Complete password reset by supplying the verified email, OTP, and new password.
  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  });
}

/// Concrete implementation of [AuthRemoteDataSource] consuming [DioClient].
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _dioClient;

  AuthRemoteDataSourceImpl({required DioClient dioClient})
    : _dioClient = dioClient;

  @override
  Future<void> forgotPassword(String email) async {
    await _dioClient.post(ApiEndpoints.forgotPassword, data: {'email': email});
  }

  @override
  Future<void> resendOtp(String email) async {
    await _dioClient.post(ApiEndpoints.resendOtp, data: {'email': email});
  }

  @override
  Future<void> verifyEmail(String email, String otp) async {
    await _dioClient.post(
      ApiEndpoints.verifyEmail,
      data: {'email': email, 'otp': otp},
    );
  }

  @override
  Future<void> validateOtp(String email, String otp) async {
    await _dioClient.post(
      ApiEndpoints.validateOtp,
      data: {'email': email, 'otp': otp},
    );
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    await _dioClient.post(
      ApiEndpoints.resetPassword,
      data: {'email': email, 'otp': otp, 'newPassword': newPassword},
    );
  }
}
