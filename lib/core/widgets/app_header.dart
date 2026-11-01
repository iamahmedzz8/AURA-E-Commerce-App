import 'package:aura_maison/core/utils/app_colors.dart';
import 'package:aura_maison/core/utils/app_strings.dart';
import 'package:aura_maison/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: AppColors.headerBackground,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: Brand Name & Title
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.brandTitle,
                style: AppStyles.brandHeader.copyWith(
                  color: AppColors.goldAccent,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                AppStrings.collectionsTitle,
                style: AppStyles.headerScreenTitle.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          // Right: Action Icons & Profile
          Row(
            children: [
              // Search Button
              IconButton(
                iconSize: 20,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
                icon: const Icon(
                  Icons.search,
                  color: AppColors.iconLight,
                ),
                onPressed: () {},
              ),
              // Notifications Button with gold badge
              Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    iconSize: 20,
                    padding: EdgeInsets.zero,
                    constraints:
                        const BoxConstraints(minWidth: 44, minHeight: 44),
                    icon: const Icon(
                      Icons.notifications_none_outlined,
                      color: AppColors.iconLight,
                    ),
                    onPressed: () {},
                  ),
                  Positioned(
                    top: 10,
                    right: 12,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.goldBright,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 4),
              // Profile Avatar Button
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.goldAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.person_outline_rounded,
                  size: 18,
                  color: AppColors.iconDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
