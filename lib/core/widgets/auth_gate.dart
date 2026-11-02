import 'package:aura_maison_e_commerce/core/services/prefs_service.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/screens/vip_member_sign_in_screen.dart';
import 'package:aura_maison_e_commerce/features/home/presentation/screens/home_screen.dart';
import 'package:aura_maison_e_commerce/features/splash/presentation/screens/splash_salon_screen.dart';
import 'package:flutter/material.dart';

/// Chooses the first screen from SharedPreferences:
/// logged in → Home · onboarding done → VIP Member Sign In · otherwise → Splash.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    if (PrefsService.isLoggedIn) {
      return const HomeScreen();
    }
    if (PrefsService.isOnboardingCompleted) {
      return const VipMemberSignInScreen();
    }
    return const SplashSalonScreen();
  }
}
