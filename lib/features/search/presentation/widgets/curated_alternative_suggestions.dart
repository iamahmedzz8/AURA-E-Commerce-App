import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CuratedAlternativeSuggestions extends StatelessWidget {
  final ValueChanged<String>? onSuggestionTap;

  const CuratedAlternativeSuggestions({
    super.key,
    this.onSuggestionTap,
  });

  static const List<String> suggestions = [
    AppStrings.suggestedChip1,
    AppStrings.suggestedChip2,
    AppStrings.suggestedChip3,
    AppStrings.suggestedChip4,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Section Eyebrow Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.suggestedCollectionsEyebrow,
                  style: AppStyles.suggestedCollectionsEyebrow.copyWith(
                    color: AppColors.goldAccent,
                  ),
                ),
                const Icon(
                  Icons.explore_outlined,
                  color: AppColors.textSecondary,
                  size: 15,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Horizontal Suggestion Chips List
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: suggestions.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final label = suggestions[index];
                return GestureDetector(
                  onTap: () => onSuggestionTap?.call(label),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.specsStripBackground,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Gold indicator dot
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: AppColors.goldAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          label,
                          style: AppStyles.suggestedCollectionChip.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
