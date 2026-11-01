import 'package:shared_preferences/shared_preferences.dart';

/// Local persistence for onboarding, remember-me, and login session flags.
class PrefsService {
  PrefsService._();

  static const _kOnboardingCompleted = 'onboarding_completed';
  static const _kIsLoggedIn = 'is_logged_in';
  static const _kRememberMe = 'remember_me';
  static const _kSavedEmail = 'saved_email';

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

  /// When [rememberMe] is true, keeps the user logged in across launches
  /// and stores the email for autofill. When false, only clears remembered data.
  static Future<void> saveLoginSession({
    required String email,
    required bool rememberMe,
  }) async {
    await _instance.setBool(_kRememberMe, rememberMe);
    if (rememberMe) {
      await _instance.setBool(_kIsLoggedIn, true);
      await _instance.setString(_kSavedEmail, email.trim());
    } else {
      await _instance.setBool(_kIsLoggedIn, false);
      await _instance.remove(_kSavedEmail);
    }
  }

  /// Clears the active session. Keeps remembered email if Remember Me is on.
  static Future<void> logout({bool clearRememberedEmail = false}) async {
    await _instance.setBool(_kIsLoggedIn, false);
    if (clearRememberedEmail) {
      await _instance.setBool(_kRememberMe, false);
      await _instance.remove(_kSavedEmail);
    }
  }
}
