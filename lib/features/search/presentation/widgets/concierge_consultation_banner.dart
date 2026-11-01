import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class ConciergeConsultationBanner extends StatelessWidget {
  final VoidCallback? onContactTap;

  const ConciergeConsultationBanner({
    super.key,
    this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 36),
      child: Stack(
        children: [
          // Main Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.cardActive,
              borderRadius: BorderRadius.circular(8),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon Medallion
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.specsStripBackground,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.chipBorder,
                      width: 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.diamond_outlined,
                    color: AppColors.goldAccent,
                    size: 18,
                  ),
                ),
                const SizedBox(height: 12),

                // Eyebrow
                Text(
                  AppStrings.bespokePrivateService,
                  style: AppStyles.conciergeEyebrow.copyWith(
                    color: AppColors.goldAccent,
                  ),
                ),
                const SizedBox(height: 6),

                // Heading
                Text(
                  AppStrings.needBespokeSearchTitle,
                  style: AppStyles.conciergeHeading.copyWith(
                    color: AppColors.textOffWhite,
                  ),
                ),
                const SizedBox(height: 8),

                // Description
                Text(
                  AppStrings.bespokeSearchDesc,
                  style: AppStyles.conciergeDesc.copyWith(
                    color: AppColors.textMutedBeige,
                  ),
                ),
                const SizedBox(height: 20),

                // Bottom Action & Status Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Status: CURATOR ONLINE
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: AppColors.statusGreen,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppStrings.curatorOnline,
                          style: AppStyles.curatorOnlineStatus.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),

                    // CTA: CONTACT THE SALON
                    GestureDetector(
                      onTap: onContactTap,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.specsStripBackground,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: AppColors.chipBorder,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppStrings.contactTheSalon,
                              style: AppStyles.contactSalonButton.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(
                              Icons.arrow_forward,
                              size: 11,
                              color: AppColors.textPrimary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Top-right subtle atmospheric gold glow accent
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.goldAccent.withValues(alpha: 0.10),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
