
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/widgets/custom_text.dart';
import 'package:aura_maison_e_commerce/features/cart/data/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CartSummary extends StatelessWidget {
  final CartModel cart;

  const CartSummary({
    super.key,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    final subtotal = cart.cartItems.fold<double>(
      0,
      (sum, item) => sum + item.totalPrice,
    );

    return Container(
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: AppStrings.cartSummary,
            weight: FontWeight.w800,
            size: 20,
          ),
          const Gap(10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: AppStrings.subtotal,
                weight: FontWeight.w600,
                size: 16,
                color: Colors.grey.shade600,
              ),
              CustomText(
                text: 'EGP ${subtotal.toStringAsFixed(2)}',
                weight: FontWeight.w600,
                size: 16,
              ),
            ],
          ),

          const Gap(5),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: AppStrings.couponDiscount,
                weight: FontWeight.w900,
                size: 18,
                color: Colors.green,
              ),
              const CustomText(
                text: 'EGP 0.00',
                weight: FontWeight.w900,
                size: 18,
                color: Colors.green,
              ),
            ],
          ),

          const Gap(5),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: AppStrings.deliveryFee,
                weight: FontWeight.w600,
                size: 16,
                color: Colors.grey.shade600,
              ),
              const CustomText(
                text: 'EGP 0.00',
                weight: FontWeight.w600,
                size: 16,
              ),
            ],
          ),

          const Gap(5),
          const Divider(),
          const Gap(5),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: AppStrings.total,
                weight: FontWeight.w800,
                size: 20,
              ),
              CustomText(
                text: 'EGP ${subtotal.toStringAsFixed(2)}',
                weight: FontWeight.w800,
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
