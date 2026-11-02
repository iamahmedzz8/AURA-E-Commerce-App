import 'package:flutter/material.dart';

import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/screens/search_screen.dart';

class AppHeader extends StatelessWidget {
  final String title;

  final bool isConcierge;
  final bool showBrand;
  final bool showSearch;
  final bool showNotifications;
  final bool showConcierge;
  final bool showBackButton;

  final VoidCallback? onBackPressed;
  final VoidCallback? onConciergePressed;

  const AppHeader({
    super.key,
    this.title = AppStrings.collectionsTitle,
    this.isConcierge = false,
    this.showBrand = true,
    this.showSearch = true,
    this.showNotifications = true,
    this.showConcierge = false,
    this.showBackButton = false,
    this.onBackPressed,
    this.onConciergePressed,
  });

  @override
  Widget build(BuildContext context) {
    if (isConcierge) {
      return Container(
        height: 64,
        color: AppColors.headerBackground,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            SizedBox(
              width: 40,
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: onBackPressed ?? () => Navigator.maybePop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.ivoryMuted,
                  size: 19,
                ),
              ),
            ),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.headerScreenTitle.copyWith(
                  color: AppColors.ivory,
                  fontSize: 20,
                ),
              ),
            ),
            _profileIcon(),
          ],
        ),
      );
    }

    return Container(
      height: 64,
      color: AppColors.headerBackground,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          if (showBackButton)
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: onBackPressed ?? () => Navigator.maybePop(context),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.ivoryMuted,
                size: 19,
              ),
            ),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showBrand)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.diamond_outlined,
                        color: AppColors.gold,
                        size: 12,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        AppStrings.brandTitle,
                        style: AppStyles.brandHeader.copyWith(
                          color: AppColors.gold,
                        ),
                      ),
                    ],
                  ),
                if (showBrand) const SizedBox(height: 2),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.headerScreenTitle.copyWith(
                    color: AppColors.ivory,
                  ),
                ),
              ],
            ),
          ),

          if (showSearch)
            IconButton(
              iconSize: 20,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 40, minHeight: 44),
              icon: const Icon(Icons.search, color: AppColors.iconLight),
              onPressed: () {
                if (title != AppStrings.searchTitle) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SearchScreen()),
                  );
                }
              },
            ),

          if (showConcierge)
            IconButton(
              iconSize: 21,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 40, minHeight: 44),
              icon: const Icon(
                Icons.support_agent_outlined,
                color: AppColors.iconLight,
              ),
              onPressed: onConciergePressed ?? () {},
            ),

          if (showNotifications)
            Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  iconSize: 20,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 40,
                    minHeight: 44,
                  ),
                  icon: const Icon(
                    Icons.notifications_none_outlined,
                    color: AppColors.iconLight,
                  ),
                  onPressed: () {},
                ),
                Positioned(
                  top: 10,
                  right: 10,
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

          const SizedBox(width: 5),
          _profileIcon(),
        ],
      ),
    );
  }

  Widget _profileIcon() {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: AppColors.gold,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(
        Icons.person_outline_rounded,
        size: 19,
        color: AppColors.iconDark,
      ),
    );
  }
}
