import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';

class RecentRegister extends StatelessWidget {
  const RecentRegister({super.key});

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
              Row(
                children: [
                  Text(
                    'MOVEMENTS & RECENT REGISTER',
                    style: TextStyle(
                      color: DarkTheme.primaryText,
                      fontSize: 10,
                      letterSpacing: 1,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 6),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: DarkTheme.gold,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: const Text(
                  'SHOW ALL',
                  style: TextStyle(
                    color: DarkTheme.gold,
                    fontSize: 10,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          _logItem(
            title: 'Transfer to Secure Vault',
            subtitle: 'Royal Tourbillon Squelette #TS-880',
            extra: 'Vendôme Suite 402 • Cell C-14',
            time: '22m ago',
            icon: Icons.check_circle_outline,
            iconColor: Colors.greenAccent,
          ),
          _logItem(
            title: 'Crafting & Saddlery Completed',
            subtitle: 'Alligator Leather Watch Trunk #MH-01',
            extra: 'Meyrin Workshop • Ready for sealing',
            time: '1h ago',
            icon: Icons.shopping_bag_outlined,
            iconColor: DarkTheme.gold,
          ),
          _logItem(
            title: 'Patron Allocation Confirmed',
            subtitle: 'Impérial Chronograph #CI-914',
            extra: 'Reserved by Paris Private Salon',
            time: '3h ago',
            icon: Icons.star_border,
            iconColor: DarkTheme.gold,
          ),
        ],
      ),
    );
  }

  Widget _logItem({
    required String title,
    required String subtitle,
    required String extra,
    required String time,
    required IconData icon,
    required Color iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(
              'assets/images/vintage_allocation_bg.png',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        subtitle,
                        style: const TextStyle(
                          color: DarkTheme.gold,
                          fontSize: 10,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        color: DarkTheme.secondaryText,
                        fontSize: 9,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    color: DarkTheme.primaryText,
                    fontSize: 14,
                    fontFamily: 'EB Garamond',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(icon, color: iconColor, size: 14),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        extra,
                        style: const TextStyle(
                          color: DarkTheme.secondaryText,
                          fontSize: 10,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
