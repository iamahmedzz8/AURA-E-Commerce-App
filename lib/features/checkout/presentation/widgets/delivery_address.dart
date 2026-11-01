import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DeliveryAddress extends StatelessWidget {
  const DeliveryAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.location_on_outlined, color: AppColors.primaryColor),
        Gap(10),
        CustomText(text: 'Delivery Address', size: 20, weight: FontWeight.bold),
        Spacer(),
        TextButton(
          onPressed: () {},
          child: CustomText(
            text: 'Change',
            size: 18,
            weight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
