import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
/// Single service privilege item tile
class OnboardingServiceItem extends StatelessWidget {
  final String title;
  final String tag;
  final String description;

  const OnboardingServiceItem({
    super.key,
    required this.title,
    required this.tag,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.obsidianCard,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.obsidianBorder, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.ivory,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.obsidianDark,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  tag,
                  style: const TextStyle(
                    color: AppColors.gold,
                    fontSize: 9.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(
              color: AppColors.luxuryMuted,
              fontSize: 11.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
