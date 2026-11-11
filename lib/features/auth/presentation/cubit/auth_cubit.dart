import 'package:aura_maison_e_commerce/core/services/prefs_service.dart';
import 'package:aura_maison_e_commerce/features/auth/domain/usecases/logout_usecase.dart';

class AuthCubit {
  final LogoutUseCase logoutUseCase;

  AuthCubit({required this.logoutUseCase});

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
  Future<void> logout({bool clearRememberedEmail = false}) async {
  try {
    await logoutUseCase.call();
  } finally {
    await PrefsService.logout(
      clearRememberedEmail: clearRememberedEmail,
    );
  }
}
}

class AuthState {}