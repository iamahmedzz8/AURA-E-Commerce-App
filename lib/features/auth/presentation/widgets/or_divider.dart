import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

/// Reusable horizontal divider with centered label
class OrDivider extends StatelessWidget {
  final String label;

  const OrDivider({
    super.key,
    this.label = 'OR CONTINUE WITH',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.border)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
              color: AppColors.muted,
              letterSpacing: 0.8,
            ),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.border)),
      ],
    );
  }
}
