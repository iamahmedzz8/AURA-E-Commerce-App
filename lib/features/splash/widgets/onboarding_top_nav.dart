import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

/// Top navigation with step indicator and skip button for onboarding
class OnboardingTopNav extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final VoidCallback onSkip;

  const OnboardingTopNav({
    super.key,
    required this.currentStep,
    this.totalSteps = 3,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Step indicators
          Row(
            children: List.generate(totalSteps, (index) {
              final isActive = index <= currentStep;
              final isCurrent = index == currentStep;
              return Container(
                margin: const EdgeInsets.only(right: 6),
                width: isCurrent ? 28 : 10,
                height: 4,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.gold : AppColors.obsidianBorder,
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: isCurrent
                      ? [
                          BoxShadow(
                            color: AppColors.gold.withOpacity(0.5),
                            blurRadius: 6,
                          )
                        ]
                      : null,
                ),
              );
            }),
          ),
          if (currentStep < totalSteps - 1)
            TextButton(
              onPressed: onSkip,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.gold,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              ),
              child: const Text(
                'SKIP INTRODUCTION',
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
            )
          else
            Text(
              '0$totalSteps / 0$totalSteps',
              style: const TextStyle(
                color: AppColors.gold,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
              ),
            ),
        ],
      ),
    );
  }
}
