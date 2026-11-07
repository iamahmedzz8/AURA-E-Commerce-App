import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class OrderTrackingSection extends StatelessWidget {
  const OrderTrackingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.tertiaryColor,
      ),
      padding: const EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/images/truck.svg',
                width: 30,
                height: 30,
              ),
              const CustomText(
                text: AppStrings.priorityCourier,
                size: 16,
                weight: FontWeight.w500,
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: const CustomText(
                  text: AppStrings.standardInsured,
                  color: Colors.green,
                  weight: FontWeight.w500,
                  size: 12,
                ),
              ),
            ],
          ),
          const Gap(10),
          Image.asset('assets/images/Progress Stepper Track.png'),
          const Gap(10),
          const Row(
            children: [
              CustomText(
                text: AppStrings.stepPayment,
                size: 12,
                weight: FontWeight.w500,
              ),
              Spacer(),
              CustomText(
                text: AppStrings.stepPackaging,
                size: 12,
                weight: FontWeight.w500,
              ),
              Spacer(),
              CustomText(
                text: AppStrings.stepOutForDelivery,
                size: 12,
                weight: FontWeight.w500,
              ),
              Spacer(),
              CustomText(
                text: AppStrings.orderStatusDelivered,
                size: 12,
                weight: FontWeight.w500,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
