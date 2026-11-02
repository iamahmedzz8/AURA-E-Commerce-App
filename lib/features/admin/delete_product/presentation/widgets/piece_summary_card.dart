import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';

class PieceSummaryCard extends StatelessWidget {
  const PieceSummaryCard({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  'https://picsum.photos/seed/watch_deleted/200/200',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: const Text(
                    'VENDOME',
                    style: TextStyle(
                      color: DarkTheme.gold,
                      fontSize: 7,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'FINE WATCHMAKING',
                      style: TextStyle(
                        color: DarkTheme.gold,
                        fontSize: 9,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '• ARCHIVE 202',
                      style: TextStyle(
                        color: DarkTheme.secondaryText.withValues(alpha: 0.6),
                        fontSize: 8,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Royal Tourbillon\nSquelette',
                  style: TextStyle(
                    color: DarkTheme.primaryText,
                    fontSize: 16,
                    height: 1.1,
                    fontFamily: 'EB Garamond',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Ref. #TS-880-OR • Calibre 8801',
                  style: TextStyle(
                    color: DarkTheme.secondaryText,
                    fontSize: 9,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: DarkTheme.background,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: DarkTheme.border),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        '142 000 €',
                        style: TextStyle(
                          color: DarkTheme.primaryText,
                          fontSize: 14,
                          fontFamily: 'EB Garamond',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '2 vaults',
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
          ),
        ],
      ),
    );
  }
}
