import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';

class IrreversibleProtocolCard extends StatelessWidget {
  const IrreversibleProtocolCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: DarkTheme.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: DarkTheme.border),
      ),
      child: Row(
        children: [
          Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle)),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'WORKSHOP DECISION • IRREVOCABLE PROTOCOL',
              style: TextStyle(color: DarkTheme.gold, fontSize: 10, letterSpacing: 1, fontFamily: 'Inter', fontWeight: FontWeight.bold, height: 1.4),
            ),
          ),
          const Icon(Icons.lock, color: DarkTheme.gold, size: 18),
        ],
      ),
    );
  }
}