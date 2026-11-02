import 'package:flutter/material.dart';
import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';

class EmptyFavoritesState extends StatelessWidget {
  final VoidCallback onExploreCollections;
  final VoidCallback onViewAllocations;

  const EmptyFavoritesState({
    super.key,
    required this.onExploreCollections,
    required this.onViewAllocations,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Lock Illustration
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              color: AppColors.obsidianCard,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Container(
                width: 112,
                height: 112,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.goldAccent.withOpacity(0.20),
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      color: AppColors.ivoryMuted.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.goldAccent.withOpacity(0.15),
                      ),
                    ),
                    child: const Icon(
                      Icons.lock_outline_rounded,
                      color: AppColors.goldAccent,
                      size: 39,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Workshop Badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: AppColors.obsidianCard,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.lock_outline,
                  color: AppColors.goldAccent,
                  size: 11,
                ),
                SizedBox(width: 4),
                Text(
                  'VENDÔME WORKSHOP',
                  style: TextStyle(
                    color: AppColors.ivoryMuted,
                    fontSize: 9,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Title
          const Text(
            'Your Favorites Are\nEmpty',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.ivory,
              fontSize: 25,
              height: 1.2,
              fontFamily: 'EB Garamond',
            ),
          ),

          const SizedBox(height: 10),

          // Description
          const Text(
            'You have not yet reserved any pieces for '
            'your private salon. Explore our workshops and '
            'save the masterpieces that catch your eye.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.luxuryMuted,
              fontSize: 12,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 24),

          // Explore Collections Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: onExploreCollections,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.goldAccent,
                foregroundColor: AppColors.iconDark,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'EXPLORE WORKSHOP COLLECTIONS',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.7,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Rare Allocations Button
          TextButton(
            onPressed: onViewAllocations,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.luxuryMuted,
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'VIEW RARE ALLOCATIONS',
                  style: TextStyle(
                    fontSize: 9,
                    letterSpacing: 0.9,
                  ),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.north_east,
                  size: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
