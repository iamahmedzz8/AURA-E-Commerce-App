import 'package:flutter/material.dart';
import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';

class FavoritesNotice extends StatelessWidget {
  const FavoritesNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 14),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: AppColors.obsidianCard,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.door_sliding_outlined,
            color: AppColors.gold,
            size: 17,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Your private salon is prepared around this watch selection.',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.ivoryMuted,
                fontSize: 11,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.chevron_right,
            color: AppColors.ivoryMuted,
            size: 20,
          ),
        ],
      ),
    );
  }
}
