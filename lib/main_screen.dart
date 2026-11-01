import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:aura_maison_e_commerce/core/widgets/app_bottom_nav_bar.dart';
import 'package:aura_maison_e_commerce/features/categories/presentation/screens/categories_screen.dart';
import 'package:aura_maison_e_commerce/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  final List<Widget> screens = [
    HomeScreen(),
    const CategoriesScreen(),
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
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: screens[currentIndex],
    );
  }
}
