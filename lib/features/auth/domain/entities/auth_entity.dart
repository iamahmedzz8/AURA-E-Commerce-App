class AuthEntity {
  final String accessToken;
  final String refreshToken;
  final DateTime expiresAtUtc;

  const AuthEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAtUtc,
  });
}
