import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class DiscreetProvenanceFooter extends StatelessWidget {
  const DiscreetProvenanceFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Row 1: Encryption & Ledger Note
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.shield_outlined,
                size: 13,
                color: AppColors.textSecondary.withValues(alpha: 0.70),
              ),
              const SizedBox(width: 8),
              Text(
                AppStrings.conciergeEncryptionNote,
                textAlign: TextAlign.center,
                style: AppStyles.provenanceFooterLedger.copyWith(
                  color: AppColors.textSecondary.withValues(alpha: 0.70),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Row 2: Atelier Locations
          Text(
            AppStrings.atelierLocations,
            textAlign: TextAlign.center,
            style: AppStyles.provenanceFooterLocations.copyWith(
              color: AppColors.textSecondary.withValues(alpha: 0.40),
            ),
          ),
        ],
      ),
    );
  }
}
