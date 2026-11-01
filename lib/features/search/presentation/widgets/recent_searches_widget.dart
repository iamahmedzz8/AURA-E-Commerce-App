import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class RecentSearchesWidget extends StatefulWidget {
  final List<String>? initialItems;
  final ValueChanged<String>? onItemSelected;
  final ValueChanged<String>? onItemDeleted;
  final VoidCallback? onClearAll;

  const RecentSearchesWidget({
    super.key,
    this.initialItems,
    this.onItemSelected,
    this.onItemDeleted,
    this.onClearAll,
  });

  @override
  State<RecentSearchesWidget> createState() => _RecentSearchesWidgetState();
}

class _RecentSearchesWidgetState extends State<RecentSearchesWidget> {
  late List<String> _items;

  @override
  void initState() {
    super.initState();
    _items = widget.initialItems != null
        ? List<String>.from(widget.initialItems!)
        : [
            AppStrings.recentPill1,
            AppStrings.recentPill2,
            AppStrings.recentPill3,
            AppStrings.recentPill4,
          ];
  }

  void _removeItem(String item) {
    setState(() {
      _items.remove(item);
    });
    widget.onItemDeleted?.call(item);
  }

  void _clearAll() {
    setState(() {
      _items.clear();
    });
    widget.onClearAll?.call();
  }

  @override
  Widget build(BuildContext context) {
    if (_items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header: RECENT SEARCHES & Clear All
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppStrings.recentSearchesTitle,
                style: AppStyles.recentSearchesHeading.copyWith(
                  color: AppColors.goldAccent,
                ),
              ),
              GestureDetector(
                onTap: _clearAll,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    AppStrings.clearAll,
                    style: AppStyles.clearAllButton.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Wrap of Dismissible Micro-Pills
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _items.map((item) {
              return Container(
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.searchBarBackground,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0D000000),
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => widget.onItemSelected?.call(item),
                      child: Text(
                        item,
                        style: AppStyles.recentSearchPillText.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _removeItem(item),
                      behavior: HitTestBehavior.opaque,
                      child: const Padding(
                        padding: EdgeInsets.all(2),
                        child: Icon(
                          Icons.close,
                          size: 10,
                          color: AppColors.recentPillClose,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
