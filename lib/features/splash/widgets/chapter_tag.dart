import 'package:flutter/material.dart';
import 'package:aura_maison/core/constants/app_colors.dart';

/// Chapter tag pill (e.g. PILLAR I • SWISS MANUFACTURE)
class ChapterTag extends StatelessWidget {
  final String tag;

  const ChapterTag(this.tag, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.obsidianCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.gold.withOpacity(0.3), width: 0.8),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          color: AppColors.gold,
          fontSize: 10,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.6,
        ),
      ),
    );
  }
}
