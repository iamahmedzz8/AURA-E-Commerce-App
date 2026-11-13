import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class BiometricAccessSection extends StatelessWidget {
  final VoidCallback? onBiometricTap;

  const BiometricAccessSection({super.key, this.onBiometricTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Luxury Ornamental Divider ──
          SizedBox(
            height: 49,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(height: 1, color: AppColors.cardActive),
                Container(
                  color: AppColors.background,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    AppStrings.vaultBiometricsDivider,
                    style: AppStyles.biometricDividerLabel.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Biometric Access Card ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
              color: AppColors.badgeBackground,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.chipBorder, width: 0.5),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.goldAccent.withValues(alpha: 0.06),
                  Colors.transparent,
                ],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Biometric Scanner Button
                GestureDetector(
                  onTap: onBiometricTap,
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.cardInactive,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.chipBorder, width: 1),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x33000000),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Outer concentric ring
                        Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.goldAccent.withValues(
                                alpha: 0.35,
                              ),
                              width: 1,
                            ),
                          ),
                        ),
                        // Inner ring
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.goldAccent.withValues(
                                alpha: 0.20,
                              ),
                              width: 1,
                            ),
                          ),
                        ),
                        // Center Face ID / Biometric Icon
                        const Icon(
                          Icons.fingerprint_rounded,
                          color: AppColors.goldAccent,
                          size: 26,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Card Title
                Text(
                  AppStrings.authenticateBiometricTitle,
                  textAlign: TextAlign.center,
                  style: AppStyles.biometricCardTitle.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),

                // Card Subtitle
                Text(
                  AppStrings.authenticateBiometricSubtitle,
                  textAlign: TextAlign.center,
                  style: AppStyles.biometricCardSubtitle.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
