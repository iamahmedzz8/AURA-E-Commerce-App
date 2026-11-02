
import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
/// Confidentiality status pill (e.g. ENCRYPTED ENCLAVE • PLACE VENDÔME)
class ConfidentialityPill extends StatelessWidget {
  final String text;

  const ConfidentialityPill({
    super.key,
    this.text = 'ENCRYPTED ENCLAVE • PLACE VENDÔME',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.obsidianDark.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.25), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
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
            text,
            style: const TextStyle(
              color: AppColors.gold,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.8,
            ),
          ),
        ],
      ),
    );
  }
}
