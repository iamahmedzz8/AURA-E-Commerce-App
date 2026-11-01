import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class BespokeCard extends StatelessWidget {
  const BespokeCard({super.key, this.onSpecialOrderTap});

  final VoidCallback? onSpecialOrderTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 48),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.cardActive,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top Atelier Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.specsStripBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                size: 20,
                color: AppColors.goldAccent,
              ),
            ),
            const SizedBox(height: 12),
            // Eyebrow
            Text(
              AppStrings.bespokeEyebrow,
              style: AppStyles.bespokeEyebrow.copyWith(
                color: AppColors.goldAccent,
              ),
            ),
            const SizedBox(height: 6),
            // Heading
            Text(
              AppStrings.bespokeTitle,
              style: AppStyles.bespokeHeading.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 10),
            // Descriptive Copy
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Text(
                AppStrings.bespokeDescription,
                textAlign: TextAlign.center,
                style: AppStyles.bespokeDescription.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // "START A SPECIAL ORDER" Button
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: onSpecialOrderTap ?? () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonDarkBackground,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.edit, size: 14, color: AppColors.goldAccent),
                    const SizedBox(width: 8),
                    Text(
                      AppStrings.startSpecialOrder,
                      style: AppStyles.specialOrderButton.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
