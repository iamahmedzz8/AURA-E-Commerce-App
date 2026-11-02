import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';

class AdminHeader extends StatelessWidget {
  const AdminHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('WORKSHOP MANAGEMENT', style: TextStyle(color: DarkTheme.gold, fontSize: 9, letterSpacing: 1.5, fontFamily: 'Inter')),
                      SizedBox(width: 20,),
                      _VendorBadge(),
                    ],
                  ),
                  Text('Workbench Fleet', style: TextStyle(color: DarkTheme.primaryText, fontSize: 20, fontFamily: 'EB Garamond', fontWeight: FontWeight.bold)),
                  SizedBox(height: 5,),
                  Text('ROLE: WORKSHOP MANAGER', style: TextStyle(color: DarkTheme.secondaryText, fontSize: 9, letterSpacing: 1, fontFamily: 'Inter')),
                ],
              ),
              const Spacer(),
              const Icon(Icons.assignment_outlined, color: DarkTheme.secondaryText, size: 20),
              const SizedBox(width: 12),
              const CircleAvatar(
                radius: 16,
                backgroundColor: DarkTheme.gold,
                child: Icon(Icons.person, size: 18, color: DarkTheme.background),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VendorBadge extends StatelessWidget {
  const _VendorBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: DarkTheme.surface,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: DarkTheme.border),
      ),
      child: const Text('VENDÔME', style: TextStyle(color: DarkTheme.gold, fontSize: 8, letterSpacing: 1, fontFamily: 'Inter')),
    );
  }
}