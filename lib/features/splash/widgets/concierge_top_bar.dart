import 'package:aura_maison/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

/// Top bar for Concierge views with AM emblem, location pill, and 3-step line
class ConciergeTopBar extends StatelessWidget {
  const ConciergeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // AM Monogram & Brand
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.gold, width: 1),
                      color: AppColors.obsidianDark,
                    ),
                    child: const Center(
                      child: Text(
                        'AM',
                        style: TextStyle(
                          fontFamily: 'serif',
                          color: AppColors.gold,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'AURA MAISON',
                    style: TextStyle(
                      color: AppColors.gold,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
              // Location Pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.obsidianCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.gold.withOpacity(0.3), width: 0.8),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.location_on, size: 10, color: AppColors.gold),
                    SizedBox(width: 4),
                    Text(
                      'PLACE VENDÔME',
                      style: TextStyle(
                        color: AppColors.gold,
                        fontSize: 9.5,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // 3-Segment Step Progress Line
          Row(
            children: [
              Expanded(child: Container(height: 2, color: AppColors.gold)),
              const SizedBox(width: 6),
              Expanded(child: Container(height: 2, color: AppColors.gold)),
              const SizedBox(width: 6),
              Expanded(child: Container(height: 2, color: AppColors.gold)),
            ],
          ),
        ],
      ),
    );
  }
}
