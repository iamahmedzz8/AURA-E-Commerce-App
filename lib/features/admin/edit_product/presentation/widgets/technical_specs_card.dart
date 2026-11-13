import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';
import '../../../../../core/utils/app_strings.dart';

class TechnicalSpecsCard extends StatelessWidget {
  const TechnicalSpecsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Row(
              children: [
                Icon(
                  Icons.build_circle_outlined,
                  color: DarkTheme.gold,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Technical Specifications',
                  style: TextStyle(
                    color: DarkTheme.primaryText,
                    fontSize: 20,
                    fontFamily: 'EB Garamond',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Text(
              'WORKSHOP N°4',
              style: TextStyle(
                color: DarkTheme.gold,
                fontSize: 9,
                letterSpacing: 1,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: DarkTheme.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: DarkTheme.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSpecText(
                'CALIBRE & MECHANISM',
                'In-House Calibre 8801 — Manual Winding',
                trailingIcon: Icons.tune,
              ),
              const SizedBox(height: 16),

              const Text(
                AppStrings.fineCraftFinishes,
                style: TextStyle(
                  color: DarkTheme.secondaryText,
                  fontSize: 9,
                  letterSpacing: 0.5,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: DarkTheme.background,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: DarkTheme.border),
                ),
                child: const Text(
                  AppStrings.craftFinishesValue,
                  style: TextStyle(
                    color: DarkTheme.primaryText,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              _buildSpecText(
                AppStrings.certificationsHallmarks,
                AppStrings.certificationsValue,
                trailingIcon: Icons.shield_outlined,
                iconColor: DarkTheme.gold,
              ),
              const SizedBox(height: 16),

              // Two compact side-by-side spec cards
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: DarkTheme.background,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: DarkTheme.border),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.powerReserve,
                            style: TextStyle(
                              color: DarkTheme.secondaryText,
                              fontSize: 9,
                              letterSpacing: 0.5,
                              fontFamily: 'Inter',
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            AppStrings.powerReserveValue,
                            style: TextStyle(
                              color: DarkTheme.gold,
                              fontSize: 18,
                              fontFamily: 'EB Garamond',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: DarkTheme.background,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: DarkTheme.border),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.calibreFrequency,
                            style: TextStyle(
                              color: DarkTheme.secondaryText,
                              fontSize: 9,
                              letterSpacing: 0.5,
                              fontFamily: 'Inter',
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            AppStrings.calibreFrequencyValue,
                            style: TextStyle(
                              color: DarkTheme.primaryText,
                              fontSize: 18,
                              fontFamily: 'EB Garamond',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSpecText(
    String label,
    String value, {
    IconData? trailingIcon,
    Color? iconColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: DarkTheme.secondaryText,
            fontSize: 9,
            letterSpacing: 0.5,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: DarkTheme.background,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: DarkTheme.border),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: DarkTheme.primaryText,
                  fontSize: 14,
                  fontFamily: 'Inter',
                ),
              ),
              if (trailingIcon != null)
                Icon(
                  trailingIcon,
                  color: iconColor ?? DarkTheme.secondaryText,
                  size: 18,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
