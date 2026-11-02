import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class VaultItem {
  final String imageUrl;
  final String badge;
  final String tag;
  final String reference;
  final String title;
  final String description;
  final String price;

  const VaultItem({
    required this.imageUrl,
    required this.badge,
    required this.tag,
    required this.reference,
    required this.title,
    required this.description,
    required this.price,
  });
}

class VaultShowcaseSection extends StatelessWidget {
  final VoidCallback? onViewAll;
  final void Function(VaultItem item)? onItemTap;
  final void Function(VaultItem item)? onAcquireTap;

  const VaultShowcaseSection({
    super.key,
    this.onViewAll,
    this.onItemTap,
    this.onAcquireTap,
  });

  static const List<VaultItem> items = [
    VaultItem(
      imageUrl:
          'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?q=80&w=600',
      badge: AppStrings.vaultPiece1Badge,
      tag: AppStrings.vaultPiece1Tag,
      reference: AppStrings.vaultPiece1Ref,
      title: AppStrings.vaultPiece1Title,
      description: AppStrings.vaultPiece1Desc,
      price: AppStrings.vaultPiece1Price,
    ),
    VaultItem(
      imageUrl:
          'https://images.unsplash.com/photo-1524805444758-089113d48a6d?q=80&w=600',
      badge: AppStrings.vaultPiece2Badge,
      tag: AppStrings.vaultPiece2Tag,
      reference: AppStrings.vaultPiece2Ref,
      title: AppStrings.vaultPiece2Title,
      description: AppStrings.vaultPiece2Desc,
      price: AppStrings.vaultPiece2Price,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Section Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.gallerySelectionEyebrow,
                    style: AppStyles.galleryEyebrow.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    AppStrings.vaultPiecesTitle,
                    style: AppStyles.vaultSectionTitle.copyWith(
                      color: AppColors.textOffWhite,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onViewAll,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppStrings.viewAllAction,
                        style: AppStyles.viewAllAction.copyWith(
                          color: AppColors.goldAccent,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward,
                        size: 11,
                        color: AppColors.goldAccent,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 2 High-End Vault Highlight Cards
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final item = items[index];
              return _VaultHighlightCard(
                item: item,
                onTap: () => onItemTap?.call(item),
                onAcquireTap: () => onAcquireTap?.call(item),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _VaultHighlightCard extends StatelessWidget {
  final VaultItem item;
  final VoidCallback? onTap;
  final VoidCallback? onAcquireTap;

  const _VaultHighlightCard({
    required this.item,
    this.onTap,
    this.onAcquireTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardInactive,
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Image Container with badges
            SizedBox(
              height: 240,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    item.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.cardActive,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.watch_outlined,
                          color: AppColors.goldAccent,
                          size: 40,
                        ),
                      );
                    },
                  ),

                  // Top-Left Micro Badge
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.badgeDarkBg,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.auto_awesome,
                            color: AppColors.goldAccent,
                            size: 11,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            item.badge,
                            style: AppStyles.vaultCardBadge.copyWith(
                              color: AppColors.specsCream,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Top-Right Vault Bookmark Button
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: AppColors.badgeDarkBg,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.bookmark_border,
                        color: AppColors.textOffWhite,
                        size: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Card Body Info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tag & Reference Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.tag,
                        style: AppStyles.vaultCardTag.copyWith(
                          color: AppColors.goldAccent,
                        ),
                      ),
                      Text(
                        item.reference,
                        style: AppStyles.vaultCardRef.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Title
                  Text(
                    item.title,
                    style: AppStyles.vaultCardTitle.copyWith(
                      color: AppColors.textOffWhite,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Description
                  Text(
                    item.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.vaultCardDesc.copyWith(
                      color: AppColors.textMutedBeige,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Acquisition Value & CTA Button Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.acquisitionValueLabel,
                            style: AppStyles.vaultPriceLabel.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.price,
                            style: AppStyles.vaultPriceValue.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: onAcquireTap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.goldAccent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                AppStrings.acquireAction,
                                style: AppStyles.vaultAcquireButton.copyWith(
                                  color: AppColors.iconDark,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.arrow_forward,
                                color: AppColors.iconDark,
                                size: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
