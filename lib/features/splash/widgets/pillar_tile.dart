import 'package:flutter/material.dart';
import 'package:aura_maison/core/constants/app_colors.dart';

/// Craft pillar tile with icon, title, subtitle and badge
class PillarTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String badge;
  final IconData icon;

  const PillarTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.obsidianCard,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.obsidianBorder, width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, size: 22, color: AppColors.gold),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.ivory,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.luxuryMuted,
                    fontSize: 9.5,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.obsidianDark,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppColors.gold.withOpacity(0.25), width: 0.8),
            ),
            child: Text(
              badge,
              style: const TextStyle(
                color: AppColors.gold,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
