import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class SearchResultsQueryBar extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClearTap;
  final VoidCallback? onFilterTap;
  final String? resultsCountText;
  final String? initialQuery;

  const SearchResultsQueryBar({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onClearTap,
    this.onFilterTap,
    this.resultsCountText,
    this.initialQuery,
  });

  @override
  State<SearchResultsQueryBar> createState() => _SearchResultsQueryBarState();
}

class _SearchResultsQueryBarState extends State<SearchResultsQueryBar> {
  late final TextEditingController _controller;
  bool _isLocalController = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController(
        text: widget.initialQuery ?? AppStrings.searchPlaceholder,
      );
      _isLocalController = true;
    } else {
      _controller = widget.controller!;
    }
  }

  @override
  void dispose() {
    if (_isLocalController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Search Input Bar
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.searchBarBackground,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1A000000),
                  offset: Offset(0, 2),
                  blurRadius: 4,
                  spreadRadius: -2,
                ),
              ],
            ),
            child: Row(
              children: [
                // Left: Search Icon (Tappable)
                GestureDetector(
                  onTap: () => widget.onSubmitted?.call(_controller.text),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 14, right: 8),
                    child: Icon(
                      Icons.search,
                      size: 16,
                      color: AppColors.goldAccent,
                    ),
                  ),
                ),

                // Middle: Text Field
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textInputAction: TextInputAction.search,
                    onChanged: widget.onChanged,
                    onSubmitted: widget.onSubmitted,
                    style: AppStyles.searchResultsQueryText.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    cursorColor: AppColors.goldAccent,
                    decoration: InputDecoration(
                      hintText: AppStrings.searchPlaceholder,
                      hintStyle: AppStyles.searchResultsQueryText.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),

                // Right: Action Buttons (Clear & Filter)
                IconButton(
                  iconSize: 12,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                  icon: const Icon(Icons.close, color: AppColors.textSecondary),
                  onPressed: () {
                    _controller.clear();
                    widget.onClearTap?.call();
                    widget.onChanged?.call('');
                  },
                ),
                const SizedBox(width: 4),

                // Salon Filter / Tune Button
                GestureDetector(
                  onTap: widget.onFilterTap,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.cardActive,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.tune_rounded,
                        size: 14,
                        color: AppColors.goldAccent,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Metadata Curator Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.cardInactive,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left: Gold Dot + Results Count
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                      widget.resultsCountText ??
                          AppStrings.searchResultsCountBanner,
                      style: AppStyles.curatorBannerFoundCount.copyWith(
                        color: AppColors.textMutedBeige,
                      ),
                    ),
                  ],
                ),

                // Right: Rosette Verified Icon + AURA CERTIFIED
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.verified_outlined,
                      size: 12,
                      color: AppColors.goldAccent,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      AppStrings.auraCertified,
                      style: AppStyles.curatorBannerCertified.copyWith(
                        color: AppColors.goldAccent,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
