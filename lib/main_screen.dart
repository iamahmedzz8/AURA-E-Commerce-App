import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:aura_maison_e_commerce/features/categories/presentation/screens/categories_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  List<Widget> screens = [
    Center(
      child: Text(
        "Home Screen",
        style: AppStyles.sectionHeading.copyWith(color: Colors.white),
      ),
    ),
    CategoriesScreen(),
    Center(
      child: Text(
        "Home Screen",
        style: AppStyles.sectionHeading.copyWith(color: Colors.white),
      ),
    ),
    Center(
      child: Text(
        "Home Screen",
        style: AppStyles.sectionHeading.copyWith(color: Colors.white),
      ),
    ),
    Center(
      child: Text(
        "Home Screen",
        style: AppStyles.sectionHeading.copyWith(color: Colors.white),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.chipBorder, width: 0.5),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.background,
          elevation: 0,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
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
      body: screens[currentIndex],
    );
  }
}
