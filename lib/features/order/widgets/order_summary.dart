import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
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
                const CustomText(
                  text: AppStrings.summaryDetails,
                  weight: FontWeight.w800,
                  size: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.tertiaryColor,
                  ),
                  child: const CustomText(
                    text: AppStrings.directDispatch,
                    weight: FontWeight.w500,
                    size: 12,
                  ),
                ),
              ],
            ),
            const Gap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  text: AppStrings.orderNumber,
                  weight: FontWeight.w500,
                  size: 16,
                ),
                const CustomText(
                  text: '#AUR-20481',
                  weight: FontWeight.bold,
                  size: 18,
                ),
              ],
            ),
            const Gap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  text: AppStrings.stepPayment,
                  weight: FontWeight.w500,
                  size: 16,
                ),
                Row(
                  children: [
                    SvgPicture.asset('assets/images/Container.svg'),
                    const CustomText(
                      text: ' Mastercard •••• 4291',
                      weight: FontWeight.w300,
                      size: 14,
                    ),
                  ],
                ),
              ],
            ),
            const Gap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  text: AppStrings.itemsCurated,
                  weight: FontWeight.w500,
                  size: 16,
                ),
                const CustomText(
                  text: '3 pieces',
                  weight: FontWeight.w300,
                  size: 14,
                ),
              ],
            ),
            const Gap(3),
            Row(
              children: [
                Image.asset('assets/images/Background_Shadow.png'),
                Image.asset('assets/images/Background_Shadow.png'),
                Image.asset('assets/images/Background_Shadow.png'),
              ],
            ),
            const Gap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  text: AppStrings.estimatedDelivery,
                  weight: FontWeight.w500,
                  size: 16,
                ),
                const CustomText(
                  text: 'Oct 28 – Oct 30',
                  weight: FontWeight.w800,
                  size: 14,
                ),
              ],
            ),
            Divider(color: Colors.grey.shade300, thickness: .8),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  text: AppStrings.total,
                  weight: FontWeight.w800,
                  size: 20,
                ),
                const CustomText(
                  text: 'EGP 1,922',
                  weight: FontWeight.w800,
                  size: 20,
                ),
              ],
            ),
            const CustomText(
              text: AppStrings.inclDeliveryAndDiscount,
              weight: FontWeight.w300,
              size: 12,
            ),
          ],
        ),
      ),
    );
  }
}
