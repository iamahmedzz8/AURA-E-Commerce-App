import 'package:aura_maison/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

/// 4-bar dynamic security gauge meter with criteria status chips
class PasswordCriteriaGauge extends StatelessWidget {
  final int score;
  final bool hasMinLength;
  final bool hasUppercase;
  final bool hasDigit;
  final bool hasSpecialChar;

  const PasswordCriteriaGauge({
    super.key,
    required this.score,
    required this.hasMinLength,
    required this.hasUppercase,
    required this.hasDigit,
    required this.hasSpecialChar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 4-bar Meter
        Row(
          children: List.generate(4, (index) {
            final isFilled = index < score;
            return Expanded(
              child: Container(
                height: 3,
                margin: EdgeInsets.only(right: index == 3 ? 0 : 4),
                decoration: BoxDecoration(
                  color: isFilled
                      ? (score == 4 ? AppColors.emerald : AppColors.gold)
                      : AppColors.obsidianElevated,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 12),
        // 4 Criteria Chips
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            _chip('8+ characters', hasMinLength),
            _chip('Uppercase letter', hasUppercase),
            _chip('Digit', hasDigit),
            _chip('Special symbol', hasSpecialChar),
          ],
        ),
      ],
    );
  }

  Widget _chip(String label, bool isMet) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isMet
            ? AppColors.emerald.withOpacity(0.12)
            : AppColors.obsidianDark,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isMet
              ? AppColors.emerald.withOpacity(0.5)
              : AppColors.obsidianBorder,
          width: 0.8,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 11,
            color: isMet ? AppColors.emerald : AppColors.luxuryMuted,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: isMet ? AppColors.ivory : AppColors.luxuryMuted,
              fontSize: 10.5,
              fontWeight: isMet ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
