
import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/features/home/presentation/screens/home_screen.dart';
import 'package:aura_maison_e_commerce/features/order/screens/order_history.dart';
import 'package:aura_maison_e_commerce/features/order/widgets/custom_button.dart';
import 'package:aura_maison_e_commerce/features/order/widgets/order_placed_section.dart';
import 'package:aura_maison_e_commerce/features/order/widgets/order_summary.dart';
import 'package:aura_maison_e_commerce/features/order/widgets/order_tracking_section.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/order_done.png',
                    width: 150,
                    height: 150,
                  ),
                ),
                OrderPlacedSection(),
                Gap(10),
                OrderTrackingSection(),
                Gap(10),
                OrderSummary(),
                Gap(10),
                CustomButton(
                  widget: const HomeScreen(),
                  buttonText: 'Continue shopping → ',
                  buttonColor: AppColors.primaryColor,
                  textColor: Colors.white,
                ),
                Gap(15),
                CustomButton(
                  widget: const OrderHistory(),
                  buttonText: '🧾 View order History ',
                  buttonColor: AppColors.tertiaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
