import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import 'salon_vitrine_card.dart';

/// Central Sanctuary section on the Salon Launch screen
class SalonCentralSanctuary extends StatelessWidget {
  const SalonCentralSanctuary({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Fluted AM Medallion with halo glow
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gold.withValues(alpha: 0.18),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
              ),
              Container(
                width: 108,
                height: 108,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.obsidianDark,
                  border: Border.all(
                    color: AppColors.gold.withValues(alpha: 0.8),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.6),
                      blurRadius: 18,
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.gold.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'AM',
                        style: TextStyle(
                          fontFamily: 'serif',
                          color: AppColors.gold,
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 3,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.obsidianCard,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.gold.withValues(alpha: 0.4),
                      width: 0.8,
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.verified_outlined,
                        size: 10,
                        color: AppColors.gold,
                      ),
                      SizedBox(width: 4),
                      Text(
                        AppStrings.certifiedUpper,
                        style: TextStyle(
                          color: AppColors.gold,
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            AppStrings.fineWatchmakingHighCraft,
            style: TextStyle(
              color: AppColors.gold,
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              letterSpacing: 2.8,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'AURA MAISON',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'serif',
              color: AppColors.ivory,
              fontSize: 34,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 18,
                height: 1,
                color: AppColors.gold.withValues(alpha: 0.4),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  AppStrings.placeVendomeGeneve,
                  style: TextStyle(
                    color: AppColors.ivoryMuted,
                    fontSize: 12,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              Container(
                width: 18,
                height: 1,
                color: AppColors.gold.withValues(alpha: 0.4),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shield_outlined,
                size: 12,
                color: AppColors.luxuryMuted,
              ),
              SizedBox(width: 6),
              Text(
                AppStrings.privatePatronExperience,
                style: TextStyle(
                  color: AppColors.luxuryMuted,
                  fontSize: 11.5,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Row(
            children: [
              Expanded(
                child: SalonVitrineCard(
                  code: AppStrings.calibre8801,
                  title: AppStrings.vendomeCelestial,
                  image: 'assets/images/vendome.png',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: SalonVitrineCard(
                  code: AppStrings.masterCrafts,
                  title: AppStrings.workshopCrafts,
                  image: 'assets/images/WorkShop.png',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
