import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({
    super.key,
    required this.orderStatus,
    required this.imageUrl,
    required this.backgroundColor,
  });
  final String orderStatus;
  final String imageUrl;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            spreadRadius: 1,
            offset: Offset(1, 3),
            color: Colors.grey.withValues(alpha: .3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: '#AUR-20481',
                    size: 20,
                    weight: FontWeight.w800,
                  ),
                  CustomText(
                    text: 'Today, 2:45 PM',
                    size: 16,
                    weight: FontWeight.w400,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: backgroundColor,
                ),
                child: CustomText(
                  text: orderStatus,
                  color: AppColors.secondaryColor,
                  size: 16,
                  weight: FontWeight.w900,
                ),
              ),
            ],
          ),
          Gap(15),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset('assets/images/watch.jpg'),
                ),
              ),
              Gap(5),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset('assets/images/watch.jpg'),
                ),
              ),
              Gap(5),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset('assets/images/watch.jpg'),
                ),
              ),
              Expanded(flex: 1, child: Container()),
            ],
          ),
          Gap(15),
          Image.asset(imageUrl, width: double.infinity),
          Gap(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: '3 Items'),
                  CustomText(
                    text: 'Total : 1,922 EGP',
                    weight: FontWeight.w700,
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: CustomText(
                  text: AppStrings.viewDetails,
                  color: AppColors.primaryColor,
                  size: 16,
                  weight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
