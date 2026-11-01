import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
/// Top header for Salon Launch / Splash view with progress line
class SalonHeader extends StatelessWidget {
  final VoidCallback? onBack;

  const SalonHeader({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: onBack ?? () => Navigator.maybePop(context),
                icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.gold),
                splashRadius: 20,
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.gold, width: 1),
                          ),
                          child: const Center(
                            child: Icon(Icons.circle, size: 4, color: AppColors.gold),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'AURA',
                          style: TextStyle(
                            fontFamily: 'serif',
                            color: AppColors.gold,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2.2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Member Authentication',
                      style: TextStyle(
                        fontFamily: 'serif',
                        color: AppColors.ivory,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: AppColors.gold,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, color: AppColors.obsidianDark, size: 18),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(height: 2, color: AppColors.gold),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Container(height: 2, color: AppColors.gold.withOpacity(0.35)),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Container(height: 2, color: AppColors.gold.withOpacity(0.35)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
