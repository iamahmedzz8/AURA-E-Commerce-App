import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service for persisting JWT tokens securely using [FlutterSecureStorage]
/// with hardware-backed AES-GCM encryption and automatic [resetOnError].
class TokenStorageService {
  final FlutterSecureStorage _secureStorage;
  final SharedPreferences? _prefs;

  static const String _kAccessToken = 'aura_access_token';
  static const String _kRefreshToken = 'aura_refresh_token';
  static const String _kExpiresAt = 'aura_expires_at';

  TokenStorageService({
    FlutterSecureStorage? secureStorage,
    SharedPreferences? prefs,
  })  : _secureStorage = secureStorage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(
                resetOnError: true,
              ),
              iOptions: IOSOptions(
                accessibility: KeychainAccessibility.first_unlock,
              ),
            ),
        _prefs = prefs;

  /// Retrieve current access token securely
  Future<String?> getAccessToken() async {
    try {
      return await _secureStorage.read(key: _kAccessToken);
    } catch (e) {
      debugPrint('[TokenStorageService] Secure read error: $e');
      return _prefs?.getString(_kAccessToken);
    }
  }

  /// Retrieve refresh token securely
  Future<String?> getRefreshToken() async {
    try {
      return await _secureStorage.read(key: _kRefreshToken);
    } catch (e) {
      debugPrint('[TokenStorageService] Secure read error: $e');
      return _prefs?.getString(_kRefreshToken);
    }
  }

  /// Retrieve expiration datetime if available
  Future<DateTime?> getExpiresAt() async {
    try {
      final raw = await _secureStorage.read(key: _kExpiresAt);
      if (raw != null) return DateTime.tryParse(raw);
    } catch (e) {
      debugPrint('[TokenStorageService] Secure read error: $e');
    }
    final fallback = _prefs?.getString(_kExpiresAt);
    return fallback != null ? DateTime.tryParse(fallback) : null;
  }

  /// Check whether an access token exists
  Future<bool> hasAccessToken() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  /// Save tokens received from login or refresh response
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    DateTime? expiresAt,
  }) async {
    try {
      await _secureStorage.write(key: _kAccessToken, value: accessToken);
      await _secureStorage.write(key: _kRefreshToken, value: refreshToken);
      if (expiresAt != null) {
        await _secureStorage.write(
          key: _kExpiresAt,
          value: expiresAt.toUtc().toIso8601String(),
        );
      }
    } catch (e) {
      debugPrint('[TokenStorageService] Secure write error: $e');
    }

    if (_prefs != null) {
      await _prefs.setString(_kAccessToken, accessToken);
      await _prefs.setString(_kRefreshToken, refreshToken);
      if (expiresAt != null) {
        await _prefs.setString(
          _kExpiresAt,
          expiresAt.toUtc().toIso8601String(),
        );
      }
    }
  }

  /// Update only access token
  Future<void> updateAccessToken(String newAccessToken) async {
    try {
      await _secureStorage.write(key: _kAccessToken, value: newAccessToken);
    } catch (e) {
      debugPrint('[TokenStorageService] Secure write error: $e');
    }
    if (_prefs != null) {
      await _prefs.setString(_kAccessToken, newAccessToken);
    }
  }

  /// Clear all stored auth tokens on logout or session expiration
  Future<void> clearTokens() async {
    try {
      await _secureStorage.delete(key: _kAccessToken);
      await _secureStorage.delete(key: _kRefreshToken);
      await _secureStorage.delete(key: _kExpiresAt);
    } catch (e) {
      debugPrint('[TokenStorageService] Secure delete error: $e');
    }
    if (_prefs != null) {
      await _prefs.remove(_kAccessToken);
      await _prefs.remove(_kRefreshToken);
      await _prefs.remove(_kExpiresAt);
    }
  }
}
