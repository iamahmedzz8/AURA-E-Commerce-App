import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

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
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(
            color: AppColors.chipBorder,
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.background,
          elevation: 0,
          currentIndex: currentIndex,
          onTap: (index) {
            if (onTap != null) {
              onTap!(index);
            } else {
              // Default global navigation behavior across pushed screens
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            }
          },
          selectedItemColor: AppColors.goldBright,
          unselectedItemColor: AppColors.textMutedBeige,
          selectedLabelStyle: AppStyles.navItemLabel.copyWith(
            color: AppColors.goldBright,
          ),
          unselectedLabelStyle: AppStyles.navItemLabel.copyWith(
            color: AppColors.textMutedBeige,
          ),
          iconSize: 20,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: AppStrings.navHome,
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.diamond_outlined),
              label: AppStrings.navCollections,
            ),
            BottomNavigationBarItem(
              icon: Badge(
                label: Text(
                  AppStrings.navBagCount,
                  style: AppStyles.navBadgeText.copyWith(
                    color: AppColors.iconDark,
                  ),
                ),
                backgroundColor: AppColors.goldAccent,
                child: const Icon(Icons.shopping_bag_outlined),
              ),
              label: AppStrings.navBag,
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border_rounded),
              label: AppStrings.navFavorites,
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: AppStrings.navProfile,
            ),
          ],
        ),
      ),
    );
  }
}
