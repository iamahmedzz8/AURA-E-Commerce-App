import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';

class AddProductTitleSection extends StatelessWidget {
  const AddProductTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: DarkTheme.gold,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'ADMISSION PROTOCOL N° 849-B',
              style: TextStyle(
                color: DarkTheme.gold,
                fontSize: 10,
                letterSpacing: 1.5,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'New Registration —\nMasterpiece',
          style: TextStyle(
            color: DarkTheme.primaryText,
            fontSize: 38,
            height: 1.1,
            fontFamily: 'EB Garamond',
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Record an exceptional piece in the\nHouse sovereign register.',
          style: TextStyle(
            color: DarkTheme.secondaryText,
            fontSize: 15,
            height: 1.4,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }
}