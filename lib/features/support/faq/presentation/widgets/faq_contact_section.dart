import 'package:flutter/material.dart';
import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';

class FaqContactSection extends StatelessWidget {
  final VoidCallback onContactPressed;

  const FaqContactSection({super.key, required this.onContactPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(22, 30, 22, 0),
      padding: const EdgeInsets.fromLTRB(20, 27, 20, 22),
      decoration: BoxDecoration(
        color: AppColors.conciergeBannerBackground,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.chipBorder, width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: AppColors.conciergeIconBackground,
              borderRadius: BorderRadius.circular(7),
            ),
            child: const Icon(
              Icons.support_agent,
              color: AppColors.goldAccent,
              size: 25,
            ),
          ),

          const SizedBox(height: 13),

          Text(
            'PRIVATE CONCIERGE',
            textAlign: TextAlign.center,
            style: AppStyles.sectionEyebrow.copyWith(
              color: AppColors.goldAccent,
              letterSpacing: 2,
              fontSize: 9,
            ),
          ),

          const SizedBox(height: 19),

          Text(
            'A specific question about your allocation?',
            textAlign: TextAlign.center,
            style: AppStyles.cardHeading.copyWith(
              color: AppColors.textPrimary,
              fontSize: 23,
              height: 1.25,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            'Our curators and master watchmakers are available '
            'to assist you with your private requests.',
            textAlign: TextAlign.center,
            style: AppStyles.cardSubtitle.copyWith(
              color: AppColors.textSecondary,
              fontSize: 11,
              height: 1.8,
            ),
          ),

          const SizedBox(height: 23),

          SizedBox(
            width: double.infinity,
            height: 49,
            child: ElevatedButton(
              onPressed: onContactPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.goldAccent,
                foregroundColor: AppColors.iconDark,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                'CONTACT THE PRIVATE CURATOR',
                textAlign: TextAlign.center,
                style: AppStyles.primaryButtonText.copyWith(
                  color: AppColors.iconDark,
                  fontSize: 10,
                  letterSpacing: 0.8,
                ),
              ),
            ),
          ),

          const SizedBox(height: 17),

          Text(
            'SECURE LINE  •  RESPONSE WITHIN 2H',
            textAlign: TextAlign.center,
            style: AppStyles.sectionCount.copyWith(
              color: AppColors.statusGreen,
              letterSpacing: 1,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}
