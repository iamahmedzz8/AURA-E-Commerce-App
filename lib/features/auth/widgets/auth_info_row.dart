import 'package:aura_maison/core/constants/app_colors.dart';

import 'package:flutter/material.dart';

/// Label-value metadata row used in info cards across auth & security views.
class AuthInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const AuthInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.valueColor = AppColors.ivory,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.luxuryMuted,
              fontSize: 9.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: valueColor,
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
