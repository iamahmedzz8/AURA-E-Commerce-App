import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class FilterSection extends StatefulWidget {
  const FilterSection({super.key, this.onSortTap, this.onClearAll});

  final VoidCallback? onSortTap;
  final VoidCallback? onClearAll;

  @override
  State<FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  bool inStockSelected = true;
  String selectedSort = AppStrings.sortCuratorsChoice;
  // Active filter micro-chips
  final List<String> activeChips = [
    AppStrings.chipFineWatchmaking,
    AppStrings.chipSednaGold,
    AppStrings.chipBespoke,
  ];
  void removeChip(int index) {
    setState(() {
      activeChips.removeAt(index);
    });
  }

  void clearAllChips() {
    setState(() {
      activeChips.clear();
    });
    widget.onClearAll?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.vitrineBackground,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Horizontal Filter Pills Scroller
          SizedBox(
            height: 32,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                // Sort Trigger Button (Curator's Choice)
                GestureDetector(
                  onTap: widget.onSortTap,
                  child: Container(
                    height: 28,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.cardActive,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.tune_rounded,
                          size: 13,
                          color: AppColors.goldAccent,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          selectedSort,
                          style: AppStyles.filterPillText.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Metals Filter Pill
                _buildFilterPill(
                  label: AppStrings.filterMetals,
                  hasDropdown: true,
                  onTap: () {},
                ),
                const SizedBox(width: 8),
                // Price Range Filter Pill
                _buildFilterPill(
                  label: AppStrings.filterPrice,
                  hasDropdown: true,
                  onTap: () {},
                ),
                const SizedBox(width: 8),
                // Availability Toggle Pill (In-Stock)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      inStockSelected = !inStockSelected;
                    });
                  },
                  child: Container(
                    height: 28,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: inStockSelected
                          ? AppColors.cardActive
                          : AppColors.cardInactive,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          inStockSelected
                              ? Icons.check_circle_rounded
                              : Icons.radio_button_unchecked_rounded,
                          size: 13,
                          color: inStockSelected
                              ? AppColors.goldAccent
                              : AppColors.textSecondary,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          AppStrings.filterInStock,
                          style: AppStyles.filterPillText.copyWith(
                            color: inStockSelected
                                ? AppColors.textPrimary
                                : AppColors.textMutedBeige,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 2. Active Filter Micro-Chips Row (shown only if chips exist)
          if (activeChips.isNotEmpty) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // "FILTERS:" Label
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        AppStrings.filtersLabel,
                        style: AppStyles.filterLabel.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    // Removable micro-chips
                    ...List.generate(activeChips.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Container(
                          height: 26,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.chipBackground,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                activeChips[index],
                                style: AppStyles.microChipText.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(width: 5),
                              GestureDetector(
                                onTap: () => removeChip(index),
                                child: const Icon(
                                  Icons.close_rounded,
                                  size: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    // "CLEAR" Button
                    GestureDetector(
                      onTap: clearAllChips,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          AppStrings.clearFilters,
                          style: AppStyles.clearButtonText.copyWith(
                            color: AppColors.goldAccent,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFilterPill({
    required String label,
    required bool hasDropdown,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 28,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.cardInactive,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppStyles.filterPillText.copyWith(
                color: AppColors.textMutedBeige,
              ),
            ),
            if (hasDropdown) ...[
              const SizedBox(width: 4),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 14,
                color: AppColors.textSecondary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
