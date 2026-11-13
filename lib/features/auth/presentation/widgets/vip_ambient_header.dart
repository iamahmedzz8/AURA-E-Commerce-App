import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class VipAmbientHeader extends StatelessWidget {
  const VipAmbientHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ambient Radial Glow Accent
          Positioned(
            top: 0,
            child: Container(
              width: 192,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.goldAccent.withValues(alpha: 0.12),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Main Header Content Column
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Maison Crest Iconography (48x48)
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.specsStripBackground,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.chipBorder, width: 1),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33000000),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.shield_outlined,
                  color: AppColors.goldAccent,
                  size: 22,
                ),
              ),
              const SizedBox(height: 12),

              // Title: Member Access
              Text(
                AppStrings.vipMemberAccessTitle,
                textAlign: TextAlign.center,
                style: AppStyles.vipHeaderTitle.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),

              // Discretion Subtitle
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 280),
                child: Text(
                  AppStrings.vipMemberAccessSubtitle,
                  textAlign: TextAlign.center,
                  style: AppStyles.vipHeaderSubtitle.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
