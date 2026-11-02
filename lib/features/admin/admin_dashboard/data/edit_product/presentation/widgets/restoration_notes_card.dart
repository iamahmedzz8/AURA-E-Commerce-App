import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';

class RestorationNotesCard extends StatelessWidget {
  const RestorationNotesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: DarkTheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: DarkTheme.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: DarkTheme.background, borderRadius: BorderRadius.circular(4), border: Border.all(color: DarkTheme.border)),
            child: const Icon(Icons.auto_awesome, color: DarkTheme.gold, size: 16),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('RESTORATION NOTES', style: TextStyle(color: DarkTheme.gold, fontSize: 9, letterSpacing: 1, fontFamily: 'Inter', fontWeight: FontWeight.bold)),
                SizedBox(height: 2),
                Text('Editing Masterpiece: Royal Tourbillon Squelette', style: TextStyle(color: DarkTheme.primaryText, fontSize: 11, fontFamily: 'Inter')),
              ],
            ),
          ),
          const Text('#TS-880-O...', style: TextStyle(color: DarkTheme.secondaryText, fontSize: 9, fontFamily: 'Inter')),
        ],
      ),
    );
  }
}