
import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/widgets/aura_text.dart';
import 'package:flutter/material.dart';


class SocialLoginButton extends StatelessWidget {
  final String label;
  final Widget leading;
  final bool dark;

  const SocialLoginButton({
    super.key,
    required this.label,
    required this.leading,
    this.dark = false,
  });

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () {},
    child: Container(
      height: 58,
      decoration: BoxDecoration(
        color: dark ? Colors.black : AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: dark ? null : Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          leading,
          const SizedBox(width: 9),
          AuraText(
            label,
            size: 14,
            weight: FontWeight.w700,
            color: dark ? Colors.white : AppColors.ink,
          ),
        ],
      ),
    ),
  );
}
