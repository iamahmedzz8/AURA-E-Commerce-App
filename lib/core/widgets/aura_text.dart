import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
/// Shared AuraText widget — used by both splash and auth modules.
class AuraText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final Color color;
  final int? maxLines;

  const AuraText(
    this.text, {
    super.key,
    this.size = 14,
    this.weight = FontWeight.w400,
    this.color = AppColors.white,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) => Text(
        text,
        maxLines: maxLines,
        overflow: maxLines == null ? null : TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: size,
          fontWeight: weight,
          color: color,
          height: 1.35,
        ),
      );
}
