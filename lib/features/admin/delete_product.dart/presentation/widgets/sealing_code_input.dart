import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';

class SealingCodeInput extends StatelessWidget {
  const SealingCodeInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: DarkTheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: DarkTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('ENTER WORKSHOP SEALING CODE', style: TextStyle(color: DarkTheme.primaryText, fontSize: 11, fontWeight: FontWeight.bold, fontFamily: 'Inter', letterSpacing: 0.5)),
              Text('REQUIRED', style: TextStyle(color: Colors.redAccent, fontSize: 9, fontWeight: FontWeight.bold, fontFamily: 'Inter', letterSpacing: 0.5)),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: DarkTheme.background,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: DarkTheme.border),
            ),
            child: TextField(
              obscureText: true,
              style: const TextStyle(color: DarkTheme.primaryText, fontSize: 14, fontFamily: 'Inter', letterSpacing: 4),
              decoration: InputDecoration(
                hintText: 'Management PIN (6 digits)',
                hintStyle: TextStyle(color: DarkTheme.secondaryText.withOpacity(0.5), fontSize: 14, fontFamily: 'Inter', letterSpacing: 0),
                border: InputBorder.none,
                icon: const Icon(Icons.key, color: DarkTheme.secondaryText, size: 18),
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              'Action tracked under the Chief Curator\'s\nauthority • Place Vendôme',
              textAlign: TextAlign.center,
              style: TextStyle(color: DarkTheme.secondaryText, fontSize: 10, height: 1.4, fontFamily: 'Inter'),
            ),
          )
        ],
      ),
    );
  }
}