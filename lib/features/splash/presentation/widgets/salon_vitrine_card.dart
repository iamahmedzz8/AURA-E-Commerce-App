import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

/// Vitrine Card showcasing complications / atelier crafts
class SalonVitrineCard extends StatelessWidget {
  final String code;
  final String title;
  final String? image;
  final IconData? icon;

  const SalonVitrineCard({
    super.key,
    required this.code,
    required this.title,
    this.image,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.obsidianCard,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.obsidianBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.obsidianDark,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: AppColors.gold.withValues(alpha: 0.15),
                ),
              ),
              child: Center(
                child: image != null
                    ? Image.asset(image!)
                    : Icon(
                        icon ?? Icons.watch_outlined,
                        size: 38,
                        color: AppColors.gold.withValues(alpha: 0.7),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            code,
            style: const TextStyle(
              color: AppColors.luxuryMuted,
              fontSize: 9.5,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'serif',
              color: AppColors.ivory,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
