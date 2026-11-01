
import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
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
          padding: EdgeInsets.all(7),
          child: CustomText(
            text: 'CONFIRMED & DISPATCHED SOON',
            size: 16,
            weight: FontWeight.w400,
          ),
        ),

        CustomText(text: 'Order placed!', size: 25, weight: FontWeight.bold),
        CustomText(
          text: '''Thank you for shopping with Aurea. Your
bespoke parcel will arrive in 3–5 business days.''',
          size: 14,
          weight: FontWeight.w400,
          maxLines: 2,
        ),
      ],
    );
  }
}
