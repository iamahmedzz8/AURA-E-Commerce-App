import 'package:shared_preferences/shared_preferences.dart';

/// Local persistence for onboarding, remember-me, tokens, and login session flags.
class PrefsService {
  PrefsService._();

  static const _kOnboardingCompleted = 'onboarding_completed';
  static const _kIsLoggedIn = 'is_logged_in';
  static const _kRememberMe = 'remember_me';
  static const _kSavedEmail = 'saved_email';
  static const _kAccessToken = 'aura_access_token';
  static const _kRefreshToken = 'aura_refresh_token';
  static const _kExpiresAt = 'aura_expires_at';

  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static SharedPreferences get _instance {
    final prefs = _prefs;
    if (prefs == null) {
      throw StateError('PrefsService.init() must be called before use.');
    }
    return prefs;
  }

  // ── Onboarding ──────────────────────────────────────────────

  static bool get isOnboardingCompleted =>
      _instance.getBool(_kOnboardingCompleted) ?? false;

  static Future<void> setOnboardingCompleted(bool value) =>
      _instance.setBool(_kOnboardingCompleted, value);

  // ── Persistent login ────────────────────────────────────────

  static bool get isLoggedIn => _instance.getBool(_kIsLoggedIn) ?? false;

  static Future<void> setLoggedIn(bool value) =>
      _instance.setBool(_kIsLoggedIn, value);

  // ── Remember Me ─────────────────────────────────────────────

  static bool get rememberMe => _instance.getBool(_kRememberMe) ?? false;

  static String get savedEmail => _instance.getString(_kSavedEmail) ?? '';

  // ── Authentication Tokens ───────────────────────────────────

  static String? get accessToken => _instance.getString(_kAccessToken);

  static String? get refreshToken => _instance.getString(_kRefreshToken);

  static DateTime? get expiresAt {
    final raw = _instance.getString(_kExpiresAt);
    if (raw == null) return null;
    return DateTime.tryParse(raw);
  }

  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    DateTime? expiresAt,
  }) async {
    await _instance.setString(_kAccessToken, accessToken);
    await _instance.setString(_kRefreshToken, refreshToken);
    if (expiresAt != null) {
      await _instance.setString(
        _kExpiresAt,
        expiresAt.toUtc().toIso8601String(),
      );
    }
  }

  static Future<void> clearTokens() async {
    await _instance.remove(_kAccessToken);
    await _instance.remove(_kRefreshToken);
    await _instance.remove(_kExpiresAt);
  }

  /// When [rememberMe] is true, keeps the user logged in across launches
  /// and stores the email for autofill. When false, only clears remembered data.
  static Future<void> saveLoginSession({
    required String email,
    required bool rememberMe,
    String? accessToken,
    String? refreshToken,
  }) async {
    await _instance.setBool(_kRememberMe, rememberMe);
    if (rememberMe) {
      await _instance.setBool(_kIsLoggedIn, true);
      await _instance.setString(_kSavedEmail, email.trim());
    } else {
      await _instance.setBool(_kIsLoggedIn, false);
      await _instance.remove(_kSavedEmail);
    }

    if (accessToken != null && refreshToken != null) {
      await saveTokens(accessToken: accessToken, refreshToken: refreshToken);
    }
  }

  /// Clears the active session. Keeps remembered email if Remember Me is on.
  static Future<void> logout({bool clearRememberedEmail = false}) async {
    await _instance.setBool(_kIsLoggedIn, false);
    await clearTokens();
    if (clearRememberedEmail) {
      await _instance.setBool(_kRememberMe, false);
      await _instance.remove(_kSavedEmail);
    }
  }
}
