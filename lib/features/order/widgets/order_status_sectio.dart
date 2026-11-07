import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/features/order/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OrderStatusSection extends StatelessWidget {
  const OrderStatusSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: const [
          OrderItem(
            orderStatus: AppStrings.orderStatusProcessingBullet,
            imageUrl: 'assets/images/Progress Stepper Track.png',
            backgroundColor: AppColors.primaryColor,
          ),
          Gap(20),
          OrderItem(
            orderStatus: AppStrings.orderStatusShippedEmoji,
            imageUrl: 'assets/images/Tracking Progress Bar (Shipped state).png',
            backgroundColor: Colors.blue,
          ),
          Gap(20),
          OrderItem(
            orderStatus: AppStrings.orderStatusDeliveredEmoji,
            imageUrl: 'assets/images/delivers.png',
            backgroundColor: Colors.green,
          ),
          Gap(15),
        ],
      ),
    );
  }
}
