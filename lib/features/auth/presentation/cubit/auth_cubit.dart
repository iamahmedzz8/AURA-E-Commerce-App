import 'package:aura_maison_e_commerce/core/services/prefs_service.dart';

/// Lightweight auth session helper backed by SharedPreferences.
/// Replace with Cubit + API when the backend layer is ready.
class AuthCubit {
  bool get isAuthenticated => PrefsService.isLoggedIn;

  Future<void> persistLogin({
    required String email,
    required bool rememberMe,
  }) {
    return PrefsService.saveLoginSession(
      email: email,
      rememberMe: rememberMe,
    );
  }

  Future<void> logout({bool clearRememberedEmail = false}) {
    return PrefsService.logout(clearRememberedEmail: clearRememberedEmail);
  }
}

/// Placeholder State for [AuthCubit].
class AuthState {
  // e.g. AuthInitial, AuthAuthenticated, AuthUnauthenticated
}
