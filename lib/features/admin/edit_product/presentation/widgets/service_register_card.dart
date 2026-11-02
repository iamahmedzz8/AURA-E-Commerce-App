import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';

class ServiceRegisterCard extends StatelessWidget {
  const ServiceRegisterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.history_edu, color: DarkTheme.gold, size: 20),
            SizedBox(width: 8),
            Text(
              'Service Register',
              style: TextStyle(
                color: DarkTheme.primaryText,
                fontSize: 20,
                fontFamily: 'EB Garamond',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: DarkTheme.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: DarkTheme.border),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: DarkTheme.background,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: DarkTheme.border),
                ),
                child: const Icon(
                  Icons.handyman_outlined,
                  color: DarkTheme.gold,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'LAST SERVICE',
                          style: TextStyle(
                            color: DarkTheme.gold,
                            fontSize: 9,
                            letterSpacing: 1,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '18 Feb 2025',
                          style: TextStyle(
                            color: DarkTheme.secondaryText,
                            fontSize: 10,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Master Watchmaker J.-B. Laurent',
                      style: TextStyle(
                        color: DarkTheme.primaryText,
                        fontSize: 14,
                        fontFamily: 'EB Garamond',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Tourbillon escapement check and\njewel lubrication under a Leica microscope.\nAmplitude measured at 298°.',
                      style: TextStyle(
                        color: DarkTheme.secondaryText.withValues(alpha: 0.8),
                        fontSize: 11,
                        fontFamily: 'Inter',
                        height: 1.5,
                      ),
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
