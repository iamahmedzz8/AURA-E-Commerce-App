import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

/// Editorial header for Concierge services (Pillar III: Bespoke Service)
class ConciergeEditorialHeader extends StatelessWidget {
  final String tag;
  final String title;
  final String description;

  const ConciergeEditorialHeader({
    super.key,
    this.tag = 'PILLAR III • BESPOKE SERVICE',
    this.title = 'Confidential\nGuidance',
    this.description =
        'Your dedicated private advisor arranges private viewings at home or in a discreet salon, with secure personal handover.',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'serif',
            color: AppColors.ivory,
            fontSize: 32,
            fontWeight: FontWeight.w400,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: const TextStyle(
            color: AppColors.ivoryMuted,
            fontSize: 13.5,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
