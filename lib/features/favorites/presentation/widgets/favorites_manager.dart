import 'package:flutter/material.dart';
import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';

class FavoritesManageBar extends StatelessWidget {
  final int itemCount;
  final VoidCallback onManage;
  final VoidCallback onTransferAll;

  const FavoritesManageBar({
    super.key,
    required this.itemCount,
    required this.onManage,
    required this.onTransferAll,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.obsidianCard,
        border: Border.symmetric(
          horizontal: BorderSide(color: AppColors.obsidianBorder, width: 0.7),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      child: Row(
        children: [
          const Icon(Icons.lock_outline, color: AppColors.goldAccent, size: 16),
          const SizedBox(width: 9),

          Expanded(
            child: Text(
              '$itemCount PIECES IN YOUR VAULT',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.ivory,
                fontSize: 9,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ),

          _buildAction(
            icon: Icons.tune,
            label: 'MANAGE',
            color: AppColors.luxuryMuted,
            onTap: onManage,
          ),

          const SizedBox(width: 8),

          _buildAction(
            icon: Icons.arrow_forward,
            label: 'TRANSFER ALL',
            color: AppColors.goldAccent,
            onTap: onTransferAll,
          ),
        ],
      ),
    );
  }

  Widget _buildAction({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 13),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 8,
                letterSpacing: 0.6,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
