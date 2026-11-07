import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: AppStrings.cartSummary, weight: FontWeight.w800, size: 20),
          Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: AppStrings.subtotal,
                weight: FontWeight.w600,
                size: 16,
                color: Colors.grey.shade600,
              ),
              CustomText(text: 'EGP 2080', weight: FontWeight.w600, size: 16),
            ],
          ),
          Gap(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: AppStrings.couponDiscount,
                weight: FontWeight.w900,
                size: 18,
                color: Colors.green,
              ),
              CustomText(
                text: '-EGP 200',
                weight: FontWeight.w900,
                size: 18,
                color: Colors.green,
                
              ),
            ],
          ),
          Gap(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: AppStrings.deliveryFee,
                weight: FontWeight.w600,
                size: 16,
                color: Colors.grey.shade600,
              ),
              CustomText(text: 'EGP 30', weight: FontWeight.w600, size: 16),
            ],
          ),
          Gap(5),
          Divider(),
          Gap(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: AppStrings.total, weight: FontWeight.w800, size: 20),
              CustomText(text: 'EGP 1900', weight: FontWeight.w800, size: 20),
            ],
          ),
        ],
      ),
    );
  }
}
