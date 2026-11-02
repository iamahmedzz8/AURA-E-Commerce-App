import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/widgets/custom_text.dart';
import 'package:aura_maison_e_commerce/core/widgets/navigation.dart';
import 'package:aura_maison_e_commerce/features/checkout/presentation/screens/checkout_screen.dart';
import 'package:flutter/material.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                onTap: ()=>NavigateTo(context: context, screen: CheckoutScreen()),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.primaryColor,
                  ),
                  child: Center(
                    child: CustomText(
                      size: 20,
                      text: 'Checkout',
                      color: Colors.white,
                      weight: FontWeight.bold,
                    ),
                  ),
                ),
              );
  }
}