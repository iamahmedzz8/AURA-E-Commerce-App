import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class SignatureCollectionItem {
  final String tag;
  final String title;
  final String count;
  final String imageUrl;

  const SignatureCollectionItem({
    required this.tag,
    required this.title,
    required this.count,
    required this.imageUrl,
  });
}

class SignatureCollectionsGrid extends StatelessWidget {
  final ValueChanged<SignatureCollectionItem>? onCardTap;

  const SignatureCollectionsGrid({super.key, this.onCardTap});

  static const List<SignatureCollectionItem> items = [
    SignatureCollectionItem(
      tag: AppStrings.bentoCard1Tag,
      title: AppStrings.bentoCard1Title,
      count: AppStrings.bentoCard1Count,
      imageUrl:
          'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?q=80&w=600',
    ),
    SignatureCollectionItem(
      tag: AppStrings.bentoCard2Tag,
      title: AppStrings.bentoCard2Title,
      count: AppStrings.bentoCard2Count,
      imageUrl:
          'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?q=80&w=600',
    ),
    SignatureCollectionItem(
      tag: AppStrings.bentoCard3Tag,
      title: AppStrings.bentoCard3Title,
      count: AppStrings.bentoCard3Count,
      imageUrl:
          'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?q=80&w=600',
    ),
    SignatureCollectionItem(
      tag: AppStrings.bentoCard4Tag,
      title: AppStrings.bentoCard4Title,
      count: AppStrings.bentoCard4Count,
      imageUrl:
          'https://images.unsplash.com/photo-1511499767150-a48a237f0083?q=80&w=600',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Section Header: SIGNATURE COLLECTIONS & SERIES I & II
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppStrings.signatureCollectionsTitle,
                style: AppStyles.signatureCollectionsHeading.copyWith(
                  color: AppColors.goldAccent,
                ),
              ),
              Text(
                AppStrings.signatureCollectionsSeries,
                style: AppStyles.signatureCollectionsSeries.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Luxury Bento 2-Col Grid (Row 1)
          Row(
            children: [
              Expanded(
                child: _BentoCard(
                  item: items[0],
                  onTap: () => onCardTap?.call(items[0]),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _BentoCard(
                  item: items[1],
                  onTap: () => onCardTap?.call(items[1]),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Luxury Bento 2-Col Grid (Row 2)
          Row(
            children: [
              Expanded(
                child: _BentoCard(
                  item: items[2],
                  onTap: () => onCardTap?.call(items[2]),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _BentoCard(
                  item: items[3],
                  onTap: () => onCardTap?.call(items[3]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BentoCard extends StatelessWidget {
  final SignatureCollectionItem item;
  final VoidCallback? onTap;

  const _BentoCard({required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 175,
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
            BoxShadow(
              color: Color(0x1A000000),
              offset: Offset(0, 4),
              blurRadius: 6,
              spreadRadius: -1,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  color: AppColors.cardActive,
                  child: const Center(
                    child: Icon(
                      Icons.image_outlined,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),

              // Gradient Overlay for Legibility
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 0.45, 1.0],
                    colors: [
                      Colors.transparent,
                      AppColors.background.withValues(alpha: 0.7),
                      AppColors.background,
                    ],
                  ),
                ),
              ),

              // Card Content
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Workshop Tag & Arrow
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          item.tag,
                          style: AppStyles.bentoCardTag.copyWith(
                            color: AppColors.goldAccent,
                          ),
                        ),
                        const Icon(
                          Icons.north_east,
                          size: 10,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Title
                    Text(
                      item.title,
                      style: AppStyles.bentoCardTitle.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Piece count
                    Text(
                      item.count,
                      style: AppStyles.bentoCardCount.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
