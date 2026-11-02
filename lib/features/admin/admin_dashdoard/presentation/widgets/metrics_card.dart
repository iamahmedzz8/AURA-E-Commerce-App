import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';

class MetricsGridSection extends StatelessWidget {
  final int listed;
  final int approved;
  final int reserved;
  final int outOfStock;

  const MetricsGridSection({
    super.key,
    required this.listed,
    required this.approved,
    required this.reserved,
    required this.outOfStock,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('STRATEGIC METRICS',
                style: TextStyle(
                    color: DarkTheme.primaryText,
                    fontSize: 11,
                    letterSpacing: 1.5,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold)),
            Text('Continuous sync',
                style: TextStyle(
                    color: DarkTheme.gold.withValues(alpha: 0.8),
                    fontSize: 15,
                    fontFamily: 'Inter')),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _MetricGridCard(
                label: 'LISTED',
                value: '$listed',
                subtitle: 'Masterpieces',
                icon: Icons.diamond_outlined,
                iconColor: DarkTheme.gold,
                footerLabel: 'Value',
                footerValue: '4.82M €',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _MetricGridCard(
                label: 'IN VAULT',
                value: '$approved',
                subtitle: 'Approved Pieces',
                icon: Icons.lock_outline,
                iconColor: Colors.greenAccent,
                footerLabel: 'Access',
                footerValue: 'Immediate',
                footerValueColor: Colors.greenAccent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _MetricGridCard(
                label: 'RESERVATIONS',
                value: '$reserved',
                subtitle: 'Target Patrons',
                icon: Icons.person_outline,
                iconColor: DarkTheme.gold,
                footerLabel: 'Status',
                footerValue: 'Under Mandate',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _MetricGridCard(
                label: 'OUT OF STOCK',
                value: '$outOfStock'.padLeft(2, '0'),
                subtitle: 'Sold-Out Calibres',
                subtitleColor: Colors.redAccent,
                icon: Icons.shopping_bag_outlined,
                iconColor: Colors.redAccent,
                footerLabel: 'Lead Time',
                footerValue: '> 12 Wks.',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MetricGridCard extends StatelessWidget {
  final String label;
  final String value;
  final String subtitle;
  final Color? subtitleColor;
  final IconData icon;
  final Color iconColor;
  final String footerLabel;
  final String footerValue;
  final Color? footerValueColor;

  const _MetricGridCard({
    required this.label,
    required this.value,
    required this.subtitle,
    this.subtitleColor,
    required this.icon,
    required this.iconColor,
    required this.footerLabel,
    required this.footerValue,
    this.footerValueColor,
  });

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
            children: [
              Text(label,
                  style: const TextStyle(
                      color: DarkTheme.secondaryText,
                      fontSize: 10,
                      letterSpacing: 1,
                      fontFamily: 'Inter')),
              Icon(icon, color: iconColor, size: 16),
            ],
          ),
          const SizedBox(height: 12),
          Text(value,
              style: const TextStyle(
                  color: DarkTheme.primaryText,
                  fontSize: 28,
                  fontFamily: 'EB Garamond',
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(
                  color: subtitleColor ?? DarkTheme.gold,
                  fontSize: 11,
                  fontFamily: 'Inter')),
          const SizedBox(height: 16),
          const Divider(color: DarkTheme.border, height: 1),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(footerLabel,
                  style: const TextStyle(
                      color: DarkTheme.secondaryText,
                      fontSize: 10,
                      fontFamily: 'Inter')),
              Text(footerValue,
                  style: TextStyle(
                      color: footerValueColor ?? DarkTheme.primaryText,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter')),
            ],
          ),
        ],
      ),
    );
  }
}