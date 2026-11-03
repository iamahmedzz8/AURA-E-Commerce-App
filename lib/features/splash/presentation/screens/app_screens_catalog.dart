import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/screens/vip_member_sign_in_screen.dart';
import 'package:aura_maison_e_commerce/features/auth/presentation/screens/create_account_screen.dart';
import 'package:flutter/material.dart';

import 'onboarding_screen.dart';
import 'private_concierge_screen.dart';

import 'splash_salon_screen.dart';

/// Screen Navigator Hub listing all pages in the AURA MAISON project.
/// Allows direct 1-tap navigation to any screen.
class AppScreensCatalog extends StatelessWidget {
  const AppScreensCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    final screens = [
      _ScreenEntry(
        title: 'Splash — Salon Launch',
        category: 'INITIAL ENTRY',
        description:
            'Biometric cryptographic entrance with AM medallion and vault sync.',
        icon: Icons.fingerprint,
        builder: (_) => const SplashSalonScreen(),
      ),
      _ScreenEntry(
        title: 'Onboarding (3 Pillars Flow)',
        category: 'WALKTHROUGH',
        description:
            'Step 1: Fine Watchmaking → Step 2: Vault Sanctuary → Step 3: Concierge.',
        icon: Icons.view_carousel_outlined,
        builder: (_) => const OnboardingScreen(),
      ),
      _ScreenEntry(
        title: 'Private Concierge (With Filters)',
        category: 'BESPOKE SERVICES',
        description:
            'Interactive UI with category filters, decoupled data models, and assigned advisor.',
        icon: Icons.room_service_outlined,
        isNew: true,
        builder: (_) => const PrivateConciergeScreen(),
      ),
      _ScreenEntry(
        title: 'Member Authentication',
        category: 'AUTH / SECURITY',
        description:
            'Sign in to access your curated private vault and synchronized bag.',
        icon: Icons.lock_outline,
        builder: (_) => const VipMemberSignInScreen(),
      ),
      _ScreenEntry(
        title: 'Create Privilege Account',
        category: 'VIP REGISTRATION',
        description:
            'Join the Inner Circle with encrypted credentials and member benefits.',
        icon: Icons.person_add_outlined,
        builder: (_) => const CreateAccountScreen(),
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.obsidianDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: AppColors.gold,
          ),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'AURA MAISON • APP SCREENS',
          style: TextStyle(
            fontFamily: 'serif',
            color: AppColors.gold,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          itemCount: screens.length,
          separatorBuilder: (_, _) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            final item = screens[index];

            return Container(
              decoration: BoxDecoration(
                color: AppColors.obsidianCard,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: item.isNew
                      ? AppColors.gold.withValues(alpha: 0.6)
                      : AppColors.obsidianBorder,
                  width: item.isNew ? 1.2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: item.builder),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: AppColors.obsidianDark,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: AppColors.gold.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Icon(
                            item.icon,
                            color: AppColors.gold,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    item.category,
                                    style: const TextStyle(
                                      color: AppColors.gold,
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  if (item.isNew) ...[
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 1.5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.emerald.withValues(
                                          alpha: 0.2,
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: AppColors.emerald,
                                          width: 0.6,
                                        ),
                                      ),
                                      child: const Text(
                                        'ACTIVE / FILTERABLE',
                                        style: TextStyle(
                                          color: AppColors.emerald,
                                          fontSize: 8.5,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.title,
                                style: const TextStyle(
                                  color: AppColors.ivory,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.description,
                                style: const TextStyle(
                                  color: AppColors.luxuryMuted,
                                  fontSize: 12,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: AppColors.gold,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ScreenEntry {
  final String title;
  final String category;
  final String description;
  final IconData icon;
  final WidgetBuilder builder;
  final bool isNew;

  const _ScreenEntry({
    required this.title,
    required this.category,
    required this.description,
    required this.icon,
    required this.builder,
    this.isNew = false,
  });
}
