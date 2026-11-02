import 'package:aura_maison_e_commerce/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class OrderGuarantee extends StatelessWidget {
  const OrderGuarantee({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 1, 21, 55),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SvgPicture.asset('assets/images/logooo.svg'),
          Gap(10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'White-Glove Guarantee',
                  color: Colors.white,
                  size: 20,
                  weight: FontWeight.bold,
                ),
                CustomText(
                  maxLines: 2,
                  text: 'Complimentary resizing & vault returns within 30days.',
                  color: Colors.white,
                  size: 12,
                  weight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
