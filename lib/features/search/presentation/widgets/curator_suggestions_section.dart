import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CuratorTrendingItem {
  final String tag;
  final String badge;
  final String title;
  final String reference;
  final String price;
  final String status;
  final bool hasGreenDot;
  final String imageUrl;

  const CuratorTrendingItem({
    required this.tag,
    required this.badge,
    required this.title,
    required this.reference,
    required this.price,
    required this.status,
    required this.hasGreenDot,
    required this.imageUrl,
  });
}

class CuratorSuggestionsSection extends StatelessWidget {
  final ValueChanged<CuratorTrendingItem>? onItemTap;
  final VoidCallback? onContactTap;

  const CuratorSuggestionsSection({
    super.key,
    this.onItemTap,
    this.onContactTap,
  });

  static const List<CuratorTrendingItem> items = [
    CuratorTrendingItem(
      tag: AppStrings.trending1Tag,
      badge: AppStrings.trending1Badge,
      title: AppStrings.trending1Title,
      reference: AppStrings.trending1Ref,
      price: AppStrings.trending1Price,
      status: AppStrings.trending1Status,
      hasGreenDot: true,
      imageUrl:
          'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?q=80&w=300',
    ),
    CuratorTrendingItem(
      tag: AppStrings.trending2Tag,
      badge: AppStrings.trending2Badge,
      title: AppStrings.trending2Title,
      reference: AppStrings.trending2Ref,
      price: AppStrings.trending2Price,
      status: AppStrings.trending2Status,
      hasGreenDot: false,
      imageUrl:
          'https://images.unsplash.com/photo-1524805444758-089113d48a6d?q=80&w=300',
    ),
    CuratorTrendingItem(
      tag: AppStrings.trending3Tag,
      badge: AppStrings.trending3Badge,
      title: AppStrings.trending3Title,
      reference: AppStrings.trending3Ref,
      price: AppStrings.trending3Price,
      status: AppStrings.trending3Status,
      hasGreenDot: true,
      imageUrl:
          'https://images.unsplash.com/photo-1605100804763-247f67b3557e?q=80&w=300',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Section Header: CURATOR'S SUGGESTIONS & Subtitle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.curatorSuggestionsTitle,
                    style: AppStyles.curatorSectionTitle.copyWith(
                      color: AppColors.goldAccent,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    AppStrings.curatorSuggestionsSubtitle,
                    style: AppStyles.curatorSectionSubtitle.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.verified_outlined,
                size: 18,
                color: AppColors.goldAccent,
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 3 Trending Items
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final item = items[index];
              return _TrendingItemCard(
                item: item,
                onTap: () => onItemTap?.call(item),
              );
            },
          ),
          const SizedBox(height: 16),

          // Concierge Direct Advisory Banner
          _ConciergeBanner(onContactTap: onContactTap),
        ],
      ),
    );
  }
}

class _TrendingItemCard extends StatelessWidget {
  final CuratorTrendingItem item;
  final VoidCallback? onTap;

  const _TrendingItemCard({
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.searchBarBackground,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              offset: Offset(0, 1),
              blurRadius: 2,
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left Thumbnail with gold tint overlay
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: SizedBox(
                width: 64,
                height: 64,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      item.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        color: AppColors.cardActive,
                        child: const Icon(
                          Icons.image_outlined,
                          size: 20,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    Container(
                      color: AppColors.goldAccent.withValues(alpha: 0.05),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Middle: Metadata & Title
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Workshop Tag & Micro-Badge
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item.tag,
                        style: AppStyles.trendingItemTag.copyWith(
                          color: AppColors.goldAccent,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.cardActive,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Text(
                          item.badge,
                          style: AppStyles.trendingItemBadge.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  // Title
                  Text(
                    item.title,
                    style: AppStyles.trendingItemTitle.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  // Reference
                  Text(
                    item.reference,
                    style: AppStyles.trendingItemRef.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Right: Price & Status
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.price,
                  style: AppStyles.trendingItemPrice.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (item.hasGreenDot) ...[
                      Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: AppColors.statusGreen,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                    ],
                    Text(
                      item.status,
                      style: AppStyles.trendingItemStatus.copyWith(
                        color: item.hasGreenDot
                            ? AppColors.statusGreen
                            : AppColors.goldAccent,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ConciergeBanner extends StatelessWidget {
  final VoidCallback? onContactTap;

  const _ConciergeBanner({this.onContactTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.conciergeBannerBackground,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 4),
            blurRadius: 6,
            spreadRadius: -4,
          ),
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 10),
            blurRadius: 15,
            spreadRadius: -3,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: Icon & Text
          Expanded(
            child: Row(
              children: [
                // Gold Icon Badge
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.conciergeIconBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.room_service_outlined,
                      size: 16,
                      color: AppColors.goldAccent,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Text Block
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppStrings.confidentialSearchTitle,
                        style: AppStyles.confidentialBannerTitle.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        AppStrings.confidentialSearchSubtitle,
                        style: AppStyles.confidentialBannerSubtitle.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Right: Contact Action Button
          GestureDetector(
            onTap: onContactTap,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: AppColors.goldAccent,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text(
                AppStrings.contactButton,
                style: AppStyles.contactButtonText.copyWith(
                  color: AppColors.iconDark,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
