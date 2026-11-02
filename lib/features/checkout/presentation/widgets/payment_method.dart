import 'package:aura_maison_e_commerce/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset('assets/images/cash.svg'),
        Gap(5),
        CustomText(text: 'Payment Method', size: 18, weight: FontWeight.bold),
        Spacer(),
        CustomText(text: 'Instant Confirmation'),
      ],
    );
  }
}
