import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import '../models/service_filter_model.dart';

/// Horizontal luxury filter bar for concierge categories.
/// Driven by [ServiceFilterModel].
class ConciergeFilterBar extends StatelessWidget {
  final List<ServiceFilterModel> filters;
  final String selectedCategoryKey;
  final ValueChanged<String> onSelected;

  const ConciergeFilterBar({
    super.key,
    required this.filters,
    required this.selectedCategoryKey,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = filter.categoryKey == selectedCategoryKey;

          return GestureDetector(
            onTap: () => onSelected(filter.categoryKey),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.gold : AppColors.obsidianCard,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppColors.gold : AppColors.obsidianBorder,
                  width: 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.gold.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (filter.icon != null) ...[
                    Icon(
                      filter.icon,
                      size: 14,
                      color: isSelected ? AppColors.obsidianDark : AppColors.gold,
                    ),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    filter.label,
                    style: TextStyle(
                      color: isSelected ? AppColors.obsidianDark : AppColors.ivory,
                      fontSize: 11.5,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
