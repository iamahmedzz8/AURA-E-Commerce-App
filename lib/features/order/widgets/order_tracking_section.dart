
import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
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
      padding: EdgeInsets.all(7),
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
              CustomText(
                text: '  Priority Courier',
                size: 16,
                weight: FontWeight.w500,
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: CustomText(
                  text: 'Standard Insured',
                  color: Colors.green,
                  weight: FontWeight.w500,
                  size: 12,
                ),
              ),
            ],
          ),
          Gap(10),
          Image.asset('assets/images/Progress Stepper Track.png'),
          Gap(10),
          Row(
            children: [
              CustomText(text: 'Payment', size: 12, weight: FontWeight.w500),
              Spacer(),
              CustomText(text: 'Packaging', size: 12, weight: FontWeight.w500),
              Spacer(),
              CustomText(
                text: 'Out for delivery',
                size: 12,
                weight: FontWeight.w500,
              ),
              Spacer(),
              CustomText(text: 'Delivered', size: 12, weight: FontWeight.w500),
            ],
          ),
        ],
      ),
    );
  }
}
