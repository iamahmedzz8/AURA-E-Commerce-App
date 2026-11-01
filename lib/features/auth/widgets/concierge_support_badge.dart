import 'package:aura_maison/core/constants/app_colors.dart';
import 'package:aura_maison/core/widgets/aura_text.dart';
import 'package:flutter/material.dart';

/// Maison Aura Concierge Support Badge
class ConciergeSupportBadge extends StatelessWidget {
  final String tag;
  final String phone;
  final String subtitle;

  const ConciergeSupportBadge({
    super.key,
    this.tag = 'MAISON AURA • PRIVATE SALON',
    this.phone = 'Dedicated Concierge Support: +33 1 42 68 00 00',
    this.subtitle = 'Absolute discretion • Line active 24h/24 • Place Vendôme',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.obsidianCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.obsidianBorder, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.gold,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                tag,
                style: const TextStyle(
                  color: AppColors.gold,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.6,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                Icons.phone_in_talk_outlined,
                size: 14,
                color: AppColors.gold,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  phone,
                  style: const TextStyle(
                    color: AppColors.ivory,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Text(
              subtitle,
              style: const TextStyle(
                color: AppColors.luxuryMuted,
                fontSize: 10,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
