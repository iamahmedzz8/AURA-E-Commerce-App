import 'package:aura_maison_e_commerce/core/services/prefs_service.dart';
import 'package:aura_maison_e_commerce/features/auth/screens/login_screen.dart';
import 'package:aura_maison_e_commerce/features/home/presentation/screens/home_screen.dart';
import 'package:aura_maison_e_commerce/features/splash/screens/splash_salon_screen.dart';
import 'package:flutter/material.dart';

/// Chooses the first screen from SharedPreferences:
/// logged in → Home · onboarding done → Login · otherwise → Splash.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    if (PrefsService.isLoggedIn) {
      return const HomeScreen();
    }
    if (PrefsService.isOnboardingCompleted) {
      return const LoginScreen();
    }
    return const SplashSalonScreen();
  }
}
