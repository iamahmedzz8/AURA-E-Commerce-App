
import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Summary details',
                  weight: FontWeight.w800,
                  size: 20,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.tertiaryColor,
                  ),
                  child: CustomText(
                    text: 'Direct dispatch',
                    weight: FontWeight.w500,
                    size: 12,
                  ),
                ),
              ],
            ),
            Gap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Order number',
                  weight: FontWeight.w500,
                  size: 16,
                ),
                CustomText(
                  text: '#AUR-20481',
                  weight: FontWeight.bold,
                  size: 18,
                ),
              ],
            ),
            Gap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: 'Payment', weight: FontWeight.w500, size: 16),
                Row(
                  children: [
                    SvgPicture.asset('assets/images/Container.svg'),
                    CustomText(
                      text: ' Mastercard •••• 4291',
                      weight: FontWeight.w300,
                      size: 14,
                    ),
                  ],
                ),
              ],
            ),
            Gap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Items (3 curated)',
                  weight: FontWeight.w500,
                  size: 16,
                ),
                CustomText(text: '3 pieces', weight: FontWeight.w300, size: 14),
              ],
            ),
            Gap(3),
            Row(
              children: [
                Image.asset('assets/images/Background_Shadow.png'),
                Image.asset('assets/images/Background_Shadow.png'),
                Image.asset('assets/images/Background_Shadow.png'),
              ],
            ),
            Gap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Estimated Delivery',
                  weight: FontWeight.w500,
                  size: 16,
                ),
                CustomText(
                  text: 'Oct 28 – Oct 30',
                  weight: FontWeight.w800,
                  size: 14,
                ),
              ],
            ),
            Divider(color: Colors.grey.shade300, thickness: .8),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: 'Total', weight: FontWeight.w800, size: 20),
                CustomText(
                  text: 'EGP 1,922',
                  weight: FontWeight.w800,
                  size: 20,
                ),
              ],
            ),
            CustomText(
              text: 'incl. EGP 30 delivery & EGP 200 discount',
              weight: FontWeight.w300,
              size: 12,
            ),
          ],
        ),
      ),
    );
  }
}
