
import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/widgets/custom_text.dart';
import 'package:aura_maison_e_commerce/features/cart/presentaion/widgets/cart_summary.dart';
import 'package:aura_maison_e_commerce/features/checkout/presentation/widgets/address_container.dart';
import 'package:aura_maison_e_commerce/features/checkout/presentation/widgets/button_and_privacy_section.dart';
import 'package:aura_maison_e_commerce/features/checkout/presentation/widgets/check_privacy.dart';
import 'package:aura_maison_e_commerce/features/checkout/presentation/widgets/delivery_address.dart';
import 'package:aura_maison_e_commerce/features/checkout/presentation/widgets/payment_method.dart';
import 'package:aura_maison_e_commerce/features/checkout/presentation/widgets/payment_section.dart';
import 'package:aura_maison_e_commerce/features/checkout/presentation/widgets/promo_code_section.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        toolbarHeight: 40,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: AppColors.primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const CustomText(
          text: 'Checkout',
          size: 25,
          weight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person_outline),
            onPressed: () {},
            style: IconButton.styleFrom(
              backgroundColor: AppColors.secondaryColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckPrivacy(),
              Gap(10),
              DeliveryAddress(),
              Gap(10),
              AddressContainer(),
              Gap(20),
              PaymentMethod(),
              Gap(10),
              PaymentSection(),
              Gap(20),
              PromoCodeSection(),
              Gap(20),
              CartSummary(),
              Gap(20),
              ButtonAndPrivacySection(),
              Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
