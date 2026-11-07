import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DeliveryAddress extends StatelessWidget {
  final VoidCallback onChange;

  const DeliveryAddress({
    super.key,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          color: AppColors.primaryColor,
        ),
        const Gap(10),
        const CustomText(
          text: AppStrings.deliveryAddress,
          size: 20,
          weight: FontWeight.bold,
        ),
        const Spacer(),
        TextButton(
          onPressed: onChange,
          child: const CustomText(
            text: AppStrings.change,
            size: 18,
            weight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}