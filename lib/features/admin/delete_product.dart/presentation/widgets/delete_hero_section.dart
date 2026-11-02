import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';

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
          child: const Icon(Icons.gpp_bad_outlined, color: Colors.redAccent, size: 40),
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
              Text('ACCREDITATION LEVEL: GENERAL MANAGEMENT', style: TextStyle(color: DarkTheme.primaryText, fontSize: 9, letterSpacing: 1, fontFamily: 'Inter', fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        const SizedBox(height: 20),


        const Text(
          'Confirm Removal of the\nPiece?',
          textAlign: TextAlign.center,
          style: TextStyle(color: DarkTheme.primaryText, fontSize: 26, height: 1.2, fontFamily: 'EB Garamond', fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),

        Text(
          'This action will permanently remove this\nmasterpiece from the catalogue and revoke its\npublic allocation at the Vendôme salon.',
          textAlign: TextAlign.center,
          style: TextStyle(color: DarkTheme.secondaryText.withOpacity(0.9), fontSize: 13, height: 1.5, fontFamily: 'Inter'),
        ),
      ],
    );
  }
}