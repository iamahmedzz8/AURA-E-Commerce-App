import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class SalonConciergeVitrineBar extends StatelessWidget {
  final VoidCallback? onCommissionTap;

  const SalonConciergeVitrineBar({super.key, this.onCommissionTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.floatingVitrineBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.chipBorder, width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x59000000),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left emblem container
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.conciergeIconBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.auto_awesome,
              color: AppColors.goldAccent,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),

          // Center text information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.bespokeWorkshopEyebrow,
                  style: AppStyles.vitrineEyebrow.copyWith(
                    color: AppColors.goldAccent,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  AppStrings.bespokeWorkshopSeek,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.vitrineSeekTitle.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),

          // Right Commission Button
          GestureDetector(
            onTap: onCommissionTap,
            child: Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: AppColors.goldAccent,
                borderRadius: BorderRadius.circular(6),
              ),
              alignment: Alignment.center,
              child: Text(
                AppStrings.commissionAction,
                style: AppStyles.vitrineCommissionButton.copyWith(
                  color: AppColors.iconDark,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
