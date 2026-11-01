import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class NoResultsQueryBar extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;

  const NoResultsQueryBar({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
  });

  @override
  State<NoResultsQueryBar> createState() => _NoResultsQueryBarState();
}

class _NoResultsQueryBarState extends State<NoResultsQueryBar> {
  late final TextEditingController _controller;
  bool _isLocalController = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController(text: AppStrings.noResultsSearchQuery);
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
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Search Input Container
          Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.searchBarBackground,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                // Gold Search Icon
                const Icon(
                  Icons.search,
                  color: AppColors.goldAccent,
                  size: 16,
                ),
                const SizedBox(width: 8),

                // Query Text Input
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onChanged: widget.onChanged,
                    onSubmitted: widget.onSubmitted,
                    style: AppStyles.noResultsInput.copyWith(
                      color: AppColors.textOffWhite,
                    ),
                    cursorColor: AppColors.goldAccent,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),

                // Clear Query Button
                GestureDetector(
                  onTap: () {
                    _controller.clear();
                    widget.onClear?.call();
                    setState(() {});
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.close,
                      color: AppColors.textSecondary,
                      size: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Metadata Status Strip (CONTEMPORARY ARCHIVE & HERITAGE • 0 RESULTS)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.archiveAndHeritage,
                  style: AppStyles.noResultsMeta.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  AppStrings.zeroResults,
                  style: AppStyles.noResultsZeroCount.copyWith(
                    color: AppColors.goldAccent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
