import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/widgets/custom_text.dart';
import 'package:aura_maison_e_commerce/features/order/widgets/order_category.dart';
import 'package:aura_maison_e_commerce/features/order/widgets/order_guarantee.dart';
import 'package:aura_maison_e_commerce/features/order/widgets/order_status_sectio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

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
          text: AppStrings.orderHistory,
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
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Column(
          children: [
            CustomText(
              text: AppStrings.orderHistorySubtitle,
              size: 13,
              maxLines: 2,
              weight: FontWeight.w400,
              align: TextAlign.center,
            ),
            Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OrderCategory(
                  text: AppStrings.categoryAll,
                  background: Colors.black,
                  textColor: Colors.white,
                ),
                OrderCategory(
                  text: AppStrings.orderStatusProcessing,
                  background: AppColors.secondaryColor,
                  textColor: Colors.black,
                ),
                OrderCategory(
                  text: AppStrings.orderStatusShipped,
                  background: AppColors.secondaryColor,
                  textColor: Colors.black,
                ),
                OrderCategory(
                  text: AppStrings.orderStatusDelivered,
                  background: AppColors.secondaryColor,
                  textColor: Colors.black,
                ),
              ],
            ),
            Gap(20),
            OrderStatusSection(),
            Gap(15),
            OrderGuarantee(),
          ],
        ),
      ),
    );
  }
}
