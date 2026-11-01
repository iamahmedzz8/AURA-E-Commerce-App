import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

/// Centerpiece quote and workshop showcase card
class CenterpieceCard extends StatelessWidget {
  final String workshopTag;
  final String quote;
  final IconData icon;

  const CenterpieceCard({
    super.key,
    required this.workshopTag,
    required this.quote,
    this.icon = Icons.watch_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.obsidianCard,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.obsidianBorder, width: 1),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.obsidianCard,
            AppColors.obsidianDark.withOpacity(0.9),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.obsidianDark,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.gold.withOpacity(0.3)),
                ),
                child: Text(
                  workshopTag,
                  style: const TextStyle(
                    color: AppColors.gold,
                    fontSize: 9.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              Icon(icon, size: 24, color: AppColors.gold.withOpacity(0.6)),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            quote,
            style: const TextStyle(
              fontFamily: 'serif',
              fontStyle: FontStyle.italic,
              color: AppColors.ivory,
              fontSize: 19,
              height: 1.35,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
