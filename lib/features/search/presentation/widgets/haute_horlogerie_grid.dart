import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class SearchProductItem {
  final String badge;
  final Color badgeBackground;
  final Color badgeTextColor;
  final String specs;
  final String reference;
  final String title;
  final String price;
  final String actionLabel;
  final Color actionBackground;
  final Color actionTextColor;
  final String imageUrl;

  const SearchProductItem({
    required this.badge,
    required this.badgeBackground,
    required this.badgeTextColor,
    required this.specs,
    required this.reference,
    required this.title,
    required this.price,
    required this.actionLabel,
    required this.actionBackground,
    required this.actionTextColor,
    required this.imageUrl,
  });
}

class HauteHorlogerieGrid extends StatelessWidget {
  final void Function(SearchProductItem item)? onProductTap;
  final void Function(SearchProductItem item)? onBookmarkTap;
  final void Function(SearchProductItem item)? onActionTap;

  const HauteHorlogerieGrid({
    super.key,
    this.onProductTap,
    this.onBookmarkTap,
    this.onActionTap,
  });

  static const List<SearchProductItem> products = [
    SearchProductItem(
      badge: AppStrings.searchProduct1Badge,
      badgeBackground: AppColors.badgeDarkBg,
      badgeTextColor: AppColors.goldAccent,
      specs: AppStrings.searchProduct1Specs,
      reference: AppStrings.searchProduct1Ref,
      title: AppStrings.searchProduct1Title,
      price: AppStrings.searchProduct1Price,
      actionLabel: AppStrings.searchProduct1Action,
      actionBackground: AppColors.goldAccent,
      actionTextColor: AppColors.iconDark,
      imageUrl:
          'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?q=80&w=400',
    ),
    SearchProductItem(
      badge: AppStrings.searchProduct2Badge,
      badgeBackground: AppColors.badgeDarkBg,
      badgeTextColor: AppColors.textSecondary,
      specs: AppStrings.searchProduct2Specs,
      reference: AppStrings.searchProduct2Ref,
      title: AppStrings.searchProduct2Title,
      price: AppStrings.searchProduct2Price,
      actionLabel: AppStrings.searchProduct2Action,
      actionBackground: AppColors.cardActive,
      actionTextColor: AppColors.textPrimary,
      imageUrl:
          'https://images.unsplash.com/photo-1524805444758-089113d48a6d?q=80&w=400',
    ),
    SearchProductItem(
      badge: AppStrings.searchProduct3Badge,
      badgeBackground: AppColors.goldAccent,
      badgeTextColor: AppColors.iconDark,
      specs: AppStrings.searchProduct3Specs,
      reference: AppStrings.searchProduct3Ref,
      title: AppStrings.searchProduct3Title,
      price: AppStrings.searchProduct3Price,
      actionLabel: AppStrings.searchProduct3Action,
      actionBackground: AppColors.goldAccent,
      actionTextColor: AppColors.iconDark,
      imageUrl:
          'https://images.unsplash.com/photo-1605100804763-247f67b3557e?q=80&w=400',
    ),
    SearchProductItem(
      badge: AppStrings.searchProduct4Badge,
      badgeBackground: AppColors.statusReservedBg,
      badgeTextColor: AppColors.textPrimary,
      specs: AppStrings.searchProduct4Specs,
      reference: AppStrings.searchProduct4Ref,
      title: AppStrings.searchProduct4Title,
      price: AppStrings.searchProduct4Price,
      actionLabel: AppStrings.searchProduct4Action,
      actionBackground: AppColors.cardActive,
      actionTextColor: AppColors.goldAccent,
      imageUrl:
          'https://images.unsplash.com/photo-1547996160-71dfabb1a7b1?q=80&w=400',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          mainAxisExtent: 382,
        ),
        itemBuilder: (context, index) {
          final item = products[index];
          return _HauteHorlogerieCard(
            item: item,
            onTap: () => onProductTap?.call(item),
            onBookmarkTap: () => onBookmarkTap?.call(item),
            onActionTap: () => onActionTap?.call(item),
          );
        },
      ),
    );
  }
}

class _HauteHorlogerieCard extends StatelessWidget {
  final SearchProductItem item;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;
  final VoidCallback? onActionTap;

  const _HauteHorlogerieCard({
    required this.item,
    this.onTap,
    this.onBookmarkTap,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.specsStripBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Image Container with badges and bookmark
            SizedBox(
              height: 208,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    item.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.cardInactive,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.watch_outlined,
                          color: AppColors.goldAccent,
                          size: 36,
                        ),
                      );
                    },
                  ),
                  // Dark bottom gradient on image for legible micro-tag
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            AppColors.background.withValues(alpha: 0.6),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Top-Left Status Provenance Badge
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: item.badgeBackground,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        item.badge,
                        style: AppStyles.productGridBadge.copyWith(
                          color: item.badgeTextColor,
                        ),
                      ),
                    ),
                  ),

                  // Top-Right Bookmark Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: onBookmarkTap,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.badgeDarkBg,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.bookmark_border,
                          color: AppColors.textPrimary,
                          size: 16,
                        ),
                      ),
                    ),
                  ),

                  // Bottom-Left Calibre Micro Badge
                  Positioned(
                    bottom: 8,
                    left: 10,
                    right: 10,
                    child: Text(
                      item.specs,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.productGridSpecs.copyWith(
                        color: AppColors.specsCream,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Info Container
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Reference
                    Text(
                      item.reference,
                      style: AppStyles.productGridRef.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Title
                    Expanded(
                      child: Text(
                        item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.productGridTitle.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),

                    // Price & Action Button Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            item.price,
                            style: AppStyles.productGridPrice.copyWith(
                              color: AppColors.goldAccent,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: onActionTap,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: item.actionBackground,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              item.actionLabel,
                              style: AppStyles.productGridAction.copyWith(
                                color: item.actionTextColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
