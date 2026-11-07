import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CheckPrivacy extends StatelessWidget {
  const CheckPrivacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.secondaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(1, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(child: SvgPicture.asset('assets/images/privacy.svg')),
          Gap(10),
          CustomText(
            text: AppStrings.fineWatchmakingEscrowProtocol,
            size: 13,
            maxLines: 1,
            space: 1.8,
            weight: FontWeight.w300,
          ),
        ],
      ),
    );
  }
}
