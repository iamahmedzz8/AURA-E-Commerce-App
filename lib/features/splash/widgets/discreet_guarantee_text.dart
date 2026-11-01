import 'package:flutter/material.dart';
import 'package:aura_maison/core/constants/app_colors.dart';
/// Discreet maison guarantee footer text
class DiscreetGuaranteeText extends StatelessWidget {
  final String text;

  const DiscreetGuaranteeText({
    super.key,
    this.text = 'AURA MAISON • PLACE VENDÔME PRIVATE SALON',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.lock_outline, size: 12, color: AppColors.luxuryMuted),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.luxuryMuted,
              fontSize: 9.5,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}
