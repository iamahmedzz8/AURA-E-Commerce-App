import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/widgets/custom_text.dart';
import 'package:aura_maison_e_commerce/core/widgets/navigation.dart';
import 'package:aura_maison_e_commerce/features/order/screens/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ButtonAndPrivacySection extends StatelessWidget {
  const ButtonAndPrivacySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => NavigateTo(context: context, screen: OrderScreen()),
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.primaryColor,
            ),
            child: Center(
              child: CustomText(
                text: AppStrings.placeOrder,
                color: Colors.white,
                weight: FontWeight.bold,
                size: 20,
              ),
            ),
          ),
        ),

        Gap(10),
        Row(
          children: [
            Icon(Icons.lock_outline_rounded, color: AppColors.primaryColor),
            Expanded(
              child: CustomText(
                text: AppStrings.checkoutSecurityGuarantee,
                size: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
