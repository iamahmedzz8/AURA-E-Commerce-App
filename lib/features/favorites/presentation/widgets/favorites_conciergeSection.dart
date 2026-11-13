import 'package:flutter/material.dart';
import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';

class FavoritesConciergeSection extends StatelessWidget {
  final String totalValue;
  final VoidCallback onScheduleVisit;

  const FavoritesConciergeSection({
    super.key,
    required this.totalValue,
    required this.onScheduleVisit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 28, 20, 32),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.obsidianCard,
        border: Border.all(color: AppColors.obsidianBorder, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Concierge label
          Row(
            children: [
              const Icon(
                Icons.diamond_outlined,
                color: AppColors.goldAccent,
                size: 16,
              ),
              const SizedBox(width: 9),
              const Text(
                'CONCIERGE GUARANTEE',
                style: TextStyle(
                  color: AppColors.goldAccent,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Main heading
          const Text(
            'Your collection, handled with discretion.',
            style: TextStyle(
              color: AppColors.ivory,
              fontSize: 25,
              height: 1.2,
              fontFamily: 'EB Garamond',
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'Our private concierge team is available to assist '
            'with your selection and arrange a personalized viewing.',
            style: TextStyle(
              color: AppColors.luxuryMuted,
              fontSize: 12,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 22),

          // Divider
          Container(height: 1, color: AppColors.obsidianBorder),

          const SizedBox(height: 20),

          // Total value
          const Text(
            'TOTAL RESERVED VALUE',
            style: TextStyle(
              color: AppColors.luxuryMuted,
              fontSize: 9,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.8,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            totalValue,
            style: const TextStyle(
              color: AppColors.goldAccent,
              fontSize: 28,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
              fontFamily: 'EB Garamond',
            ),
          ),

          const SizedBox(height: 22),

          // Private visit button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: onScheduleVisit,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.goldAccent,
                side: const BorderSide(color: AppColors.goldAccent, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_month_outlined, size: 16),
                  SizedBox(width: 10),
                  Text(
                    'SCHEDULE A PRIVATE VISIT',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
