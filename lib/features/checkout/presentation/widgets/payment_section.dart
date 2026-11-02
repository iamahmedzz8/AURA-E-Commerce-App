import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.3),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(1, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Checkbox(
                value: true,
                onChanged: (va) {},
                shape: CircleBorder(),
                fillColor: WidgetStateProperty.all(AppColors.primaryColor),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          text: 'Pay Online',
                          size: 18,
                          weight: FontWeight.bold,
                        ),
                        Spacer(),
                        SvgPicture.asset('assets/images/visa.svg'),
                        Gap(5),

                        SvgPicture.asset('assets/images/mc.svg'),
                        Gap(5),
                        SvgPicture.asset('assets/images/paypal.svg'),
                        Gap(5),
                      ],
                    ),
                    Gap(7),
                    CustomText(
                      text: 'Credit/Debit Card, Apple Pay & Digital Wallets',
                      size: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Gap(20),
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade200,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.3),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(1, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Checkbox(
                value: false,
                onChanged: (va) {},
                shape: CircleBorder(),
                fillColor: WidgetStateProperty.all(Colors.grey.shade300),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Cash on delivery',
                      size: 18,
                      weight: FontWeight.bold,
                    ),
                    Gap(7),
                    CustomText(
                      text: 'Pay safely upon physical delivery inspection',
                      size: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
