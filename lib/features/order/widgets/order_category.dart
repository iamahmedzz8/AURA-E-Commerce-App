import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class OrderCategory extends StatelessWidget {
  final Color? background, textColor;
  final String text;
  const OrderCategory({
    super.key,
    this.background,
    this.textColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: background ?? AppColors.tertiaryColor,
      ),
      child: CustomText(
        text: text,
        color: textColor ?? Colors.black,
        size: 16,
        weight: FontWeight.w500,
      ),
    );
  }
}
