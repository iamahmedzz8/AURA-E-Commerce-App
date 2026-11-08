import '../entities/auth_entity.dart';

abstract class AuthRepository {
  Future<AuthEntity> login({
    required String email,
    required String password,
  });

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  });

  Future<void> logout();
}