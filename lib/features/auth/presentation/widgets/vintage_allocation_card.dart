import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

/// Element 2: 2025 Vintage Allocation Showcase Card
/// Figma Node: 26:14 ("Margin" -> "Background+Shadow")
class VintageAllocationCard extends StatelessWidget {
  const VintageAllocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Container(
        height: 128,
        decoration: BoxDecoration(
          color: AppColors.cardInactive,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.chipBorder, width: 0.5),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Vintage Watch Visual
              Image.asset(
                'assets/images/vintage_allocation_bg.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.cardInactive,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.watch_outlined,
                      size: 40,
                      color: AppColors.goldAccent,
                    ),
                  );
                },
              ),

              // Atmospheric Darkening Gradient Overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      const Color(0xFF080B10),
                      const Color(0xFF080B10).withValues(alpha: 0.4),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),

              // Bottom Metadata Bar
              Positioned(
                left: 16,
                right: 16,
                bottom: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Allocation Indicator & Badge
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: AppColors.goldAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppStrings.allocationVintageBadge,
                          style: AppStyles.allocationBadgeText.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),

                    // Restricted Access Status
                    Text(
                      AppStrings.restrictedAccessLabel,
                      style: AppStyles.restrictedAccessText.copyWith(
                        color: AppColors.goldAccent.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
