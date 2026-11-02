import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';

class EditAppBar extends StatelessWidget {
  const EditAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: DarkTheme.gold, size: 18),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: 8),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    'WORKSHOP\nREGISTER',
                    style: TextStyle(color: DarkTheme.gold, fontSize: 9, height: 1.1, letterSpacing: 0.5, fontFamily: 'Inter', fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 20),
                  _ConfidentialBadge(),
                ],
              ),
              SizedBox(height: 2),
              Text(
                'Bespoke Commission Review',
                style: TextStyle(color: DarkTheme.primaryText, fontSize: 18, fontFamily: 'EB Garamond', fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 2),
              Text(
                'ROLE: WORKSHOP MANAGER • VENDÔME',
                style: TextStyle(color: DarkTheme.secondaryText, fontSize: 8, letterSpacing: 0.5, fontFamily: 'Inter'),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Stack(
          alignment: Alignment.center,
          children: const [
            Icon(Icons.shield_outlined, color: DarkTheme.secondaryText, size: 20),
            Padding(padding: EdgeInsets.only(top: 2), child: Icon(Icons.check, color: DarkTheme.secondaryText, size: 10)),
          ],
        ),
        const SizedBox(width: 12),
        const CircleAvatar(radius: 16, backgroundColor: DarkTheme.gold, child: Icon(Icons.person, size: 18, color: DarkTheme.background)),
      ],
    );
  }
}

class _ConfidentialBadge extends StatelessWidget {
  const _ConfidentialBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: DarkTheme.surface, borderRadius: BorderRadius.circular(3), border: Border.all(color: DarkTheme.border)),
      child: const Text('CONFIDENTIAL', style: TextStyle(color: DarkTheme.gold, fontSize: 7, letterSpacing: 0.5, fontFamily: 'Inter', fontWeight: FontWeight.w600)),
    );
  }
}