import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';

class DashboardTitleAndStatus extends StatelessWidget {
  final String totalValue;

  const DashboardTitleAndStatus({super.key, required this.totalValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: DarkTheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: DarkTheme.border),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.circle, color: DarkTheme.gold, size: 8),
              SizedBox(width: 6),
              Text(
                'LEVEL IV ACCREDITATION • VENDÔME & MEYRIN',
                style: TextStyle(
                  color: DarkTheme.gold,
                  fontSize: 9,
                  letterSpacing: 1,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'CENTRAL FINE WATCHMAKING\nREGISTER',
          style: TextStyle(
            color: DarkTheme.secondaryText,
            fontSize: 10,
            letterSpacing: 1.5,
            fontFamily: 'Inter',
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Text(
                    'Workshop Management',
                    style: TextStyle(
                      color: DarkTheme.primaryText,
                      fontSize: 28,
                      fontFamily: 'EB Garamond',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: DarkTheme.surface,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: DarkTheme.border),
              ),
              child: const Row(
                children: [
                  Icon(Icons.lock_outline, color: DarkTheme.gold, size: 14),
                  SizedBox(width: 4),
                  Text(
                    'SHA-\n256',
                    style: TextStyle(
                      color: DarkTheme.gold,
                      fontSize: 9,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: DarkTheme.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: DarkTheme.border),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: DarkTheme.background,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: DarkTheme.border),
                ),
                child: const Icon(
                  Icons.security,
                  color: DarkTheme.gold,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'RESTRICTED ADMINISTRATION CONSOLE',
                      style: TextStyle(
                        color: DarkTheme.gold,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Workshop Management Mode Active • Meyrin & Vendôme',
                      style: TextStyle(
                        color: DarkTheme.secondaryText,
                        fontSize: 10,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          width: double.infinity,
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: DarkTheme.border),
            image: const DecorationImage(
              image: AssetImage('assets/images/vintage_allocation_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.3),
                      Colors.black.withValues(alpha: 0.85),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'VENDÔME VAULT • LOCK ACTIVE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            letterSpacing: 1,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Estimated Total Inventory',
                          style: TextStyle(
                            color: DarkTheme.secondaryText,
                            fontSize: 11,
                            fontFamily: 'Inter',
                          ),
                        ),
                        Text(
                          totalValue,
                          style: TextStyle(
                            color: DarkTheme.gold,
                            fontSize: 28,
                            fontFamily: 'EB Garamond',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
