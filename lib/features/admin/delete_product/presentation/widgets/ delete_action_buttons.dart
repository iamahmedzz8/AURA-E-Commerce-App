import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';

class DeleteActionButtons extends StatelessWidget {
  const DeleteActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: DarkTheme.secondaryText.withValues(
                alpha: 0.5,
              ), // باهت
              side: BorderSide(color: DarkTheme.border.withValues(alpha: 0.5)),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            onPressed: null,
            icon: const Icon(Icons.delete_outline, size: 18),
            label: const Text(
              'REMOVE PERMANENTLY FROM REGISTER',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                fontSize: 11,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: DarkTheme.gold,
              foregroundColor: DarkTheme.background,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.inventory_2_outlined, size: 18),
            label: const Text(
              'KEEP PIECE IN INVENTORY',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
