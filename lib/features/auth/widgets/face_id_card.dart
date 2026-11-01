import 'package:aura_maison/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import 'aura_text.dart';

/// Face ID biometric quick access vitrine card
class FaceIdCard extends StatelessWidget {
  final VoidCallback? onEnable;

  const FaceIdCard({
    super.key,
    this.onEnable,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.field,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.face_retouching_natural, size: 27),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuraText(
                  'Face ID Quick Access',
                  size: 13,
                  weight: FontWeight.w700,
                ),
                AuraText(
                  'Enabled for this device',
                  size: 11,
                  color: AppColors.muted,
                ),
              ],
            ),
          ),
          TextButton.icon(
            onPressed: onEnable,
            icon: const Icon(Icons.lock_open, size: 14, color: AppColors.orangeDark),
            label: const Text(
              'Verify',
              style: TextStyle(
                color: AppColors.orangeDark,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
