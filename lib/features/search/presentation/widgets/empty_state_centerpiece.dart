import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class EmptyStateCenterpiece extends StatelessWidget {
  final VoidCallback? onClearSearch;

  const EmptyStateCenterpiece({
    super.key,
    this.onClearSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background soft radial gold glow
          Positioned(
            top: 20,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.goldAccent.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Content Column
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Architectural Astrolabe / Compass Vector Emblem
              SizedBox(
                width: 112,
                height: 112,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer Concentric Astrolabe Ring
                    Container(
                      width: 104,
                      height: 104,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.goldAccent.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                    ),
                    // Inner secondary thin dashed / faint ring
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.goldAccent.withValues(alpha: 0.12),
                          width: 1,
                        ),
                      ),
                    ),
                    // Inner Vitrine Medallion
                    Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        color: AppColors.cardActive.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.chipBorder,
                          width: 1,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x33000000),
                            blurRadius: 16,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.search_off_outlined,
                        color: AppColors.goldAccent,
                        size: 34,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Eyebrow
              Text(
                AppStrings.recordNotFoundEyebrow,
                textAlign: TextAlign.center,
                style: AppStyles.emptyStateEyebrow.copyWith(
                  color: AppColors.goldAccent,
                ),
              ),
              const SizedBox(height: 8),

              // Heading
              Text(
                AppStrings.noMatchingMasterpieceHeading,
                textAlign: TextAlign.center,
                style: AppStyles.emptyStateHeading.copyWith(
                  color: AppColors.textOffWhite,
                ),
              ),
              const SizedBox(height: 12),

              // Description
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 290),
                child: Text(
                  AppStrings.noMatchingMasterpieceDesc,
                  textAlign: TextAlign.center,
                  style: AppStyles.emptyStateDesc.copyWith(
                    color: AppColors.textMutedBeige,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Outlined Reset Button
              GestureDetector(
                onTap: onClearSearch,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.cardInactive,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: AppColors.chipBorder,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.refresh,
                        color: AppColors.goldAccent,
                        size: 14,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        AppStrings.clearSearchAction,
                        style: AppStyles.emptyStateButton.copyWith(
                          color: AppColors.goldAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
