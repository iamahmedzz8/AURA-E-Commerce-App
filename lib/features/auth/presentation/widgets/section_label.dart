
import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/widgets/aura_text.dart';
import 'package:flutter/material.dart';


class SectionLabel extends StatelessWidget {
  final String title;
  final String trailing;

  const SectionLabel({super.key, required this.title, required this.trailing});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AuraText(title, size: 14, weight: FontWeight.w700),
          AuraText(trailing, size: 12, weight: FontWeight.w600, color: AppColors.muted),
        ],
      );
}
