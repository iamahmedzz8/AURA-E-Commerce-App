import 'package:aura_maison_e_commerce/core/services/prefs_service.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/screens/vip_member_sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:aura_maison_e_commerce/core/services/token_storage_service.dart';
import 'package:aura_maison_e_commerce/core/di/injection_container.dart';
import 'package:aura_maison_e_commerce/main_screen.dart';
import '../widgets/confidentiality_pill.dart';
import '../widgets/salon_central_sanctuary.dart';
import '../widgets/salon_entrance_portal.dart';
import '../widgets/salon_header.dart';
import 'onboarding_screen.dart';

/// Splash — Salon Launch Screen (Node 1:3)
/// Main entry point of AURA MAISON luxury experience.
class SplashSalonScreen extends StatelessWidget {
  const SplashSalonScreen({super.key});

  Future<void> _enterSalon(BuildContext context) async {
    if (!PrefsService.isOnboardingCompleted) {
      if (!context.mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        ),
      );
      return;
    }

    final tokenStorage = sl<TokenStorageService>();
    final accessToken = await tokenStorage.getAccessToken();

    if (!context.mounted) return;

    final Widget next = accessToken != null && accessToken.isNotEmpty
        ? const MainScreen()
        : const VipMemberSignInScreen();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => next),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  const SalonHeader(),
                  const SizedBox(height: 12),
                  const ConfidentialityPill(),
                  const SizedBox(height: 18),
                  const SalonCentralSanctuary(),
                  const Spacer(),
                  SalonEntrancePortal(onEnter: () => _enterSalon(context)),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
