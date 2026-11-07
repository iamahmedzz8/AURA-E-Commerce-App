import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';
import '../../../../../core/utils/app_strings.dart';

class DeleteHeroSection extends StatelessWidget {
  const DeleteHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: DarkTheme.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: DarkTheme.border),
          ),
          child: const Icon(
            Icons.gpp_bad_outlined,
            color: Colors.redAccent,
            size: 40,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: DarkTheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: DarkTheme.border),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.circle, color: DarkTheme.gold, size: 6),
              SizedBox(width: 6),
              Text(
                AppStrings.accreditationGeneralManagement,
                style: TextStyle(
                  color: DarkTheme.primaryText,
                  fontSize: 9,
                  letterSpacing: 1,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          AppStrings.confirmRemovalTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: DarkTheme.primaryText,
            fontSize: 26,
            height: 1.2,
            fontFamily: 'EB Garamond',
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          AppStrings.confirmRemovalSubtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: DarkTheme.secondaryText.withValues(alpha: 0.9),
            fontSize: 13,
            height: 1.5,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }
}
