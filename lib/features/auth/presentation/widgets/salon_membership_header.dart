import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

/// Element 1: Application Header & Circle Introduction for Salon Membership Application
/// Figma Node: 26:4 ("Container")
class SalonMembershipHeader extends StatelessWidget {
  const SalonMembershipHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Eyebrow with Gold Star Emblem
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, size: 12, color: AppColors.goldAccent),
              const SizedBox(width: 8),
              Text(
                AppStrings.patronsCircleEyebrow,
                style: AppStyles.patronsCircleEyebrow.copyWith(
                  color: AppColors.goldAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Main Serif Heading
          Text(
            AppStrings.salonMembershipHeading,
            style: AppStyles.salonMembershipHeading.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),

          // Subtitle / Salon Description
          Text(
            AppStrings.salonMembershipSubtitle,
            style: AppStyles.salonMembershipSubtitle.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
