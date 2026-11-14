import 'package:aura_maison_e_commerce/core/services/token_storage_service.dart';

abstract class AuthLocalDataSource {
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required DateTime expiresAtUtc,
  });

  Future<void> clearTokens();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final TokenStorageService tokenStorageService;

  AuthLocalDataSourceImpl({required this.tokenStorageService});

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required DateTime expiresAtUtc,
  }) {
    return tokenStorageService.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresAt: expiresAtUtc,
    );
  }

  @override
  Future<void> clearTokens() {
    return tokenStorageService.clearTokens();
  }
}
