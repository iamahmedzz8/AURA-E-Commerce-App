
import 'package:flutter/material.dart';
import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';

class FaqQuestionCard extends StatelessWidget {
  final String question;
  final String answer;
  final bool isExpanded;
  final VoidCallback onTap;

  const FaqQuestionCard({
    super.key,
    required this.question,
    required this.answer,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isExpanded
            ? AppColors.cardActive
            : AppColors.cardInactive,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: isExpanded
              ? AppColors.goldAccent.withOpacity(0.35)
              : AppColors.chipBorder,
          width: 0.8,
        ),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(5),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 19,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      question,
                      style: AppStyles.cardHeading.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 17,
                        height: 1.35,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Icon(
                    isExpanded
                        ? Icons.remove
                        : Icons.add,
                    color: AppColors.goldAccent,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),

          if (isExpanded) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Container(
                height: 0.7,
                color: AppColors.headerDivider,
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(18, 17, 18, 21),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  answer,
                  textAlign: TextAlign.left,
                  style: AppStyles.productDescription.copyWith(
                    color: AppColors.textMutedBeige,
                    fontSize: 12,
                    height: 1.85,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
