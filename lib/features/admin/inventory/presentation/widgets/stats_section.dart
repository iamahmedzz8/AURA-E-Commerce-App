import 'package:flutter/material.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: _StatCard(
              label: 'SEALED VALUE',
              value: '8 420 500 €',
              subValue: '48 pieces under mandate',
              icon: Icons.lock_outline,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _StatCard(
              label: 'ALLOCATION RATE',
              value: '91.6%',
              subValue: 'Vendôme Vault & Salon',
              icon: Icons.check_circle_outline,
              iconColor: Colors.greenAccent,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String subValue;
  final IconData icon;
  final Color? iconColor;

  const _StatCard({
    required this.label,
    required this.value,
    required this.subValue,
    required this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: textTheme.labelLarge?.copyWith(
                    color: textTheme.bodyMedium?.color,
                    fontSize: 10,
                  ),
                ),
                Icon(
                  icon,
                  size: 14,
                  color: iconColor ?? textTheme.bodyMedium?.color,
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(value, style: textTheme.titleLarge?.copyWith(fontSize: 18)),
            SizedBox(height: 4),
            Text(subValue, style: textTheme.bodyMedium?.copyWith(fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
