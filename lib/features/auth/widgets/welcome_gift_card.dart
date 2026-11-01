
import 'package:aura_maison/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import 'aura_text.dart';

/// Complimentary welcome gift banner card
class WelcomeGiftCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const WelcomeGiftCard({
    super.key,
    this.title = 'Complimentary Welcome Gift',
    this.subtitle =
        'Receive a curated watch microfiber kit with your initial order.',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.card_giftcard,
            color: AppColors.orangeDark,
            size: 24,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuraText(
                  title,
                  size: 10.5,
                  weight: FontWeight.w700,
                ),
                AuraText(
                  subtitle,
                  size: 9.5,
                  color: AppColors.muted,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
