import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';

class DeclassificationEffectsList extends StatelessWidget {
  const DeclassificationEffectsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('IMMEDIATE EFFECTS OF DECLASSIFICATION', style: TextStyle(color: DarkTheme.secondaryText, fontSize: 10, letterSpacing: 1, fontFamily: 'Inter', fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        _buildEffectItem(
          icon: Icons.link_off,
          iconColor: Colors.redAccent,
          title: 'Salon & digital showcase revocation',
          subtitle: 'Instant removal from sales tablets\nand international private salons.',
        ),
        const SizedBox(height: 10),
        _buildEffectItem(
          icon: Icons.verified_user_outlined,
          iconColor: DarkTheme.gold,
          title: 'Notarized seal on authenticity certificate',
          subtitle: 'The cryptographic passport enters the\nclassified archive vault with perpetual\ntimestamping.',
        ),
        const SizedBox(height: 10),
        _buildEffectItem(
          icon: Icons.notifications_active_outlined,
          iconColor: DarkTheme.gold,
          title: 'Discreet notification to collectors',
          subtitle: 'Silent update sent to the concierges\nof the 7 patrons who reserved\nan option right.',
        ),
      ],
    );
  }

  Widget _buildEffectItem({required IconData icon, required Color iconColor, required String title, required String subtitle}) {
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
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: DarkTheme.background, borderRadius: BorderRadius.circular(4), border: Border.all(color: DarkTheme.border)),
            child: Icon(icon, color: iconColor, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: DarkTheme.primaryText, fontSize: 12, fontFamily: 'Inter', fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: DarkTheme.secondaryText.withOpacity(0.8), fontSize: 10, height: 1.4, fontFamily: 'Inter')),
              ],
            ),
          )
        ],
      ),
    );
  }
}