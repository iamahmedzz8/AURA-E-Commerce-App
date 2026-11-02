import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';

class PieceIdentityCard extends StatelessWidget {
  const PieceIdentityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.watch_outlined, color: DarkTheme.gold, size: 20),
            SizedBox(width: 8),
            Text('Piece Identity', style: TextStyle(color: DarkTheme.primaryText, fontSize: 20, fontFamily: 'EB Garamond', fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: DarkTheme.surface, borderRadius: BorderRadius.circular(8), border: Border.all(color: DarkTheme.border)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('TIMEPIECE NAME', style: TextStyle(color: DarkTheme.secondaryText, fontSize: 9, letterSpacing: 1, fontFamily: 'Inter', fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                decoration: BoxDecoration(color: DarkTheme.background, borderRadius: BorderRadius.circular(4), border: Border.all(color: DarkTheme.border)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Royal Tourbillon Squelette', style: TextStyle(color: DarkTheme.primaryText, fontSize: 15, fontFamily: 'Inter')),
                    Icon(Icons.edit, color: DarkTheme.gold, size: 16),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('WORKSHOP\nREFERENCE', style: TextStyle(color: DarkTheme.secondaryText, fontSize: 9, letterSpacing: 0.5, height: 1.2, fontFamily: 'Inter', fontWeight: FontWeight.w600)),
                  Row(
                    children: [
                      Icon(Icons.lock_outline, color: DarkTheme.gold, size: 12),
                      SizedBox(width: 4),
                      Text('CRYPTOGRAPHICALLY\nLOCKED', style: TextStyle(color: DarkTheme.gold, fontSize: 8, letterSpacing: 0.5, height: 1.2, fontFamily: 'Inter', fontWeight: FontWeight.bold)),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                decoration: BoxDecoration(color: DarkTheme.background, borderRadius: BorderRadius.circular(4), border: Border.all(color: DarkTheme.border)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('#TS-880-OR', style: TextStyle(color: DarkTheme.gold, fontSize: 16, fontFamily: 'EB Garamond', fontWeight: FontWeight.w600)),
                    Icon(Icons.key, color: DarkTheme.secondaryText, size: 16),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text('Immutability key recorded in the House ledger\nat Place Vendôme.', style: TextStyle(color: DarkTheme.secondaryText.withOpacity(0.7), fontSize: 10, fontFamily: 'Inter', height: 1.4)),
              const SizedBox(height: 16),
              const Text('FINE WATCHMAKING CLASSIFICATION', style: TextStyle(color: DarkTheme.secondaryText, fontSize: 9, letterSpacing: 1, fontFamily: 'Inter', fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(color: DarkTheme.background, borderRadius: BorderRadius.circular(4), border: Border.all(color: DarkTheme.border)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    dropdownColor: DarkTheme.surface,
                    icon: const Icon(Icons.keyboard_arrow_down, color: DarkTheme.secondaryText, size: 18),
                    hint: const Text('High Complication', style: TextStyle(color: DarkTheme.primaryText, fontSize: 14, fontFamily: 'Inter')),
                    items: const [],
                    onChanged: (value) {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}