import 'package:flutter/material.dart';
import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';

class FaqSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const FaqSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Container(
        height: 49,
        decoration: BoxDecoration(
          color: AppColors.searchBarBackground,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.chipBorder, width: 0.8),
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          cursorColor: AppColors.goldAccent,
          style: AppStyles.searchInputText.copyWith(
            color: AppColors.textPrimary,
            fontSize: 12,
          ),
          decoration: InputDecoration(
            hintText: 'Find an answer or protocol...',
            hintStyle: AppStyles.searchInputText.copyWith(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: AppColors.goldAccent,
              size: 20,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                controller.clear();
                onChanged('');
              },
              icon: const Icon(
                Icons.close,
                color: AppColors.textSecondary,
                size: 17,
              ),
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }
}
