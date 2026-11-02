
import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
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
        children: [
          OrderItem(
            orderStatus: '• Processing',
            imageUrl: 'assets/images/Progress Stepper Track.png',
            backgroundColor: AppColors.primaryColor,
          ),
          Gap(20),
          OrderItem(
            orderStatus: '🚚 Shipped',
            imageUrl: 'assets/images/Tracking Progress Bar (Shipped state).png',
            backgroundColor: Colors.blue,
          ),
          Gap(20),
          OrderItem(
            orderStatus: '🎉 Delivered',
            imageUrl: 'assets/images/delivers.png',
            backgroundColor: Colors.green,
          ),
          Gap(15),
        ],
      ),
    );
  }
}
