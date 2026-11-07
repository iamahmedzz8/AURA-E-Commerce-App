import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class OrderPlacedSection extends StatelessWidget {
  const OrderPlacedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.tertiaryColor,
          ),
          padding: const EdgeInsets.all(7),
          child: const CustomText(
            text: AppStrings.confirmedDispatchedSoon,
            size: 16,
            weight: FontWeight.w400,
          ),
        ),

        const CustomText(
          text: AppStrings.orderPlaced,
          size: 25,
          weight: FontWeight.bold,
        ),
        const CustomText(
          text: AppStrings.orderPlacedSubtitle,
          size: 14,
          weight: FontWeight.w400,
          maxLines: 2,
        ),
      ],
    );
  }
}
