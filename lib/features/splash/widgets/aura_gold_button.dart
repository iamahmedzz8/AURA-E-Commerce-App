import 'package:flutter/material.dart';
import 'package:aura_maison/core/constants/app_colors.dart';
/// Full-width gold CTA button
class AuraGoldButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final IconData? icon;

  const AuraGoldButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon = Icons.arrow_forward,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.gold,
          foregroundColor: AppColors.obsidianDark,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          elevation: 4,
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: 8),
              Icon(icon, size: 15, color: AppColors.obsidianDark),
            ],
          ],
        ),
      ),
    );
  }
}
