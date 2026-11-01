
import 'package:aura_maison_e_commerce/core/widgets/custom_text.dart';
import 'package:aura_maison_e_commerce/features/cart/presentaion/widgets/cart_cupon_widget.dart';
import 'package:aura_maison_e_commerce/features/cart/presentaion/widgets/cart_item_widget.dart';
import 'package:aura_maison_e_commerce/features/cart/presentaion/widgets/cart_summary.dart';
import 'package:aura_maison_e_commerce/features/cart/presentaion/widgets/checkout_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, elevation: 0, scrolledUnderElevation: 0,backgroundColor: Colors.transparent,),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Shopping Bag',
                    size: 22,
                    weight: FontWeight.w600,
                  ),

                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xffF3E8CC),
                    ),
                    child: Center(child: CustomText(text: '3 items')),
                  ),
                ],
              ),
              Gap(20),
              Expanded(
                child: ListView.separated(
                  itemCount: 3,
                  separatorBuilder: (context, index) => const Gap(12),
                  itemBuilder: (context, index) {
                    return const CartItemWidget();
                  },
                ),
              ),
              Gap(10),
              CartCuponWidget(),
              Gap(10),

              CartSummary(),
              CheckoutButton()
            ],
          ),
        ),
      ),
    );
  }
}
