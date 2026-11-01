import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/services/prefs_service.dart';
import 'package:aura_maison_e_commerce/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';

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
    final Widget next = PrefsService.isOnboardingCompleted
        ? const LoginScreen()
        : const OnboardingScreen();

    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => next),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.obsidian,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height -
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
                  SalonEntrancePortal(
                    onEnter: () => _enterSalon(context),
                  ),
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
