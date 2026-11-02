import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

/// Discreet encryption and security footnote
class EncryptionFooterNote extends StatelessWidget {
  final String text;
  final IconData icon;

  const EncryptionFooterNote({
    super.key,
    this.text =
        'End-to-end encryption under the Aura private watchmaking protocol. Sessions expire automatically after inactivity.',
    this.icon = Icons.enhanced_encryption_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.gold, size: 16),
        const SizedBox(width: 9),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.luxuryMuted,
              fontSize: 11,
              height: 1.55,
            ),
          ),
        ),
      ],
    );
  }
}
