import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:ios26_bottom_navigationbar/ios26_bottom_navigationbar.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const AppBottomNavBar({
    super.key,
    this.currentIndex = 1,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 27),
      child: IOS26BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          onTap?.call(index);
        },
        style: (isDark
            ? IOS26NavThemeData.dark()
            : IOS26NavThemeData.light())
            .copyWith(
          activeColor: AppColors.goldBright,
          blurSigmaX: 5,
          blurSigmaY: 5
        ),
        items: [
          IOS26NavItem.icon(
            icon: Icons.home_outlined,
            activeIcon: Icons.home_rounded,
            label: AppStrings.navHome,
          ),
          IOS26NavItem.icon(
            icon: Icons.diamond_outlined,
            activeIcon: Icons.diamond,
            label: AppStrings.navCollections,
          ),
          IOS26NavItem.icon(
            icon: Icons.shopping_bag_outlined,
            activeIcon: Icons.shopping_bag,
            label: AppStrings.navBag,
            badgeCount: int.tryParse(AppStrings.navBagCount),
          ),
          IOS26NavItem.icon(
            icon: Icons.bookmark_border_rounded,
            activeIcon: Icons.bookmark_rounded,
            label: AppStrings.navFavorites,
          ),
          IOS26NavItem.icon(
            icon: Icons.account_circle_outlined,
            activeIcon: Icons.account_circle,
            label: AppStrings.navProfile,
          ),
        ],
      ),
    );
  }
}
