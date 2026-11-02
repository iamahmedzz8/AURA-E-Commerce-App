import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';

class FooterNote extends StatelessWidget {
  const FooterNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: DarkTheme.surface,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: DarkTheme.border),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.verified_user, color: DarkTheme.gold, size: 16),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('NOTARIZED INTEGRITY REGISTER',
                    style: TextStyle(
                        color: DarkTheme.primaryText,
                        fontSize: 10,
                        letterSpacing: 1,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(
                  'Tamper-proof SHA-256 cryptographic audit log. Any physical or software alteration to the caliber register is sealed under notarized mandate with the House Master Watchmaker.',
                  style: TextStyle(
                      color: DarkTheme.secondaryText,
                      fontSize: 9,
                      height: 1.5,
                      fontFamily: 'Inter'),
                ),
                SizedBox(height: 6),
                Text('NODE VSM-04 · STATUS: IMMUTABLE',
                    style: TextStyle(
                        color: DarkTheme.gold,
                        fontSize: 8,
                        letterSpacing: 1,
                        fontFamily: 'Inter')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}