import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

/// Cryptographic session status pill banner (e.g. Salon Session 7F4-VDM, TLS 1.3)
class SessionSecurityBanner extends StatelessWidget {
  final String sessionCode;
  final String statusText;
  final String protocolBadge;

  const SessionSecurityBanner({
    super.key,
    this.sessionCode = 'SALON SESSION / 7F4-VDM',
    this.statusText = 'Cryptographic guarantee active',
    this.protocolBadge = 'TLS 1.3',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.obsidianCard,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: AppColors.obsidianBorder, width: 0.8),
      ),
      child: Row(
        children: [
          const Icon(Icons.circle, color: AppColors.emerald, size: 9),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sessionCode,
                  style: const TextStyle(
                    color: AppColors.gold,
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  statusText,
                  style: const TextStyle(
                    color: AppColors.luxuryMuted,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.shield_outlined,
            color: AppColors.luxuryMuted,
            size: 17,
          ),
          const SizedBox(width: 4),
          Text(
            protocolBadge,
            style: const TextStyle(
              color: AppColors.ivoryMuted,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
