
import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/widgets/aura_text.dart';
import 'package:flutter/material.dart';


class StatusLine extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final String? trailing;

  const StatusLine({
    super.key,
    required this.icon,
    required this.text,
    this.color = AppColors.mint,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 7),
          Expanded(child: AuraText(text, size: 11, color: AppColors.muted, weight: FontWeight.w500)),
          if (trailing != null)
            AuraText(trailing!, size: 11, color: AppColors.orangeDark, weight: FontWeight.w700),
        ],
      );
}
