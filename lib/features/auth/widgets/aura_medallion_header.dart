import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

/// Hero Medallion with halo glow, protocol tag, title, and descriptive subtitle
class AuraMedallionHeader extends StatelessWidget {
  final IconData icon;
  final String tag;
  final String title;
  final String subtitle;
  final Widget? extraChild;

  const AuraMedallionHeader({
    super.key,
    required this.icon,
    required this.tag,
    required this.title,
    required this.subtitle,
    this.extraChild,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 6),
          // Halo Glow Medallion
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gold.withValues(alpha: 0.18),
                      blurRadius: 34,
                      spreadRadius: 6,
                    ),
                  ],
                ),
              ),
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.obsidianDark,
                  border: Border.all(
                    color: AppColors.gold.withValues(alpha: 0.7),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      blurRadius: 14,
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.gold.withValues(alpha: 0.25),
                        width: 1,
                      ),
                    ),
                    child: Icon(icon, size: 26, color: AppColors.gold),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          // Protocol Tag Pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.obsidianCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.gold.withValues(alpha: 0.3),
                width: 0.8,
              ),
            ),
            child: Text(
              tag,
              style: const TextStyle(
                color: AppColors.gold,
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'serif',
              color: AppColors.ivory,
              fontSize: 26,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.luxuryMuted,
              fontSize: 13.5,
              height: 1.5,
            ),
          ),
          if (extraChild != null) ...[
            const SizedBox(height: 6),
            extraChild!,
          ],
        ],
      ),
    );
  }
}
