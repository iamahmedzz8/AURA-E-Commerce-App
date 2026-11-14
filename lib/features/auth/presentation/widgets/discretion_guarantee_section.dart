import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

/// Element 5: Salon Member Redirect & Watchmaking Discretion Guarantee
/// Figma Nodes: 26:123 ("Margin" -> "Container") & 26:132 ("Margin" -> "Background")
class DiscretionGuaranteeSection extends StatelessWidget {
  final VoidCallback? onSignInTap;

  const DiscretionGuaranteeSection({super.key, this.onSignInTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. Member Redirect Prompt
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppStrings.alreadyMemberQuestion,
                style: AppStyles.alreadyMemberQuestion.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onSignInTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppStrings.enterPrivateSalonLink,
                      style: AppStyles.enterPrivateSalonLink.copyWith(
                        color: AppColors.goldAccent,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.arrow_forward,
                      size: 12,
                      color: AppColors.goldAccent,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // 2. Discretion Guarantee Showcase Card
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cardInactive,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.chipBorder, width: 0.5),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Shield Emblem
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.badgeBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.chipBorder, width: 0.5),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.shield_outlined,
                    size: 20,
                    color: AppColors.goldAccent,
                  ),
                ),
                const SizedBox(width: 14),

                // Guarantee Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.discretionGuaranteeTitle,
                        style: AppStyles.discretionGuaranteeTitle.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppStrings.discretionGuaranteeSubtitle,
                        style: AppStyles.discretionGuaranteeSubtitle.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
