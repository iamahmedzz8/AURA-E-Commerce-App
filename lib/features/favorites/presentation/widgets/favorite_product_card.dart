
import 'package:flutter/material.dart';

import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:aura_maison_e_commerce/features/categories/data/models/product_item_model.dart';

class FavoriteProductCard extends StatelessWidget {
  final ProductItemModel product;
  final VoidCallback onRemove;
  final VoidCallback onMoveToBag;
  final VoidCallback? onSecondaryAction;

  const FavoriteProductCard({
    super.key,
    required this.product,
    required this.onRemove,
    required this.onMoveToBag,
    this.onSecondaryAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.obsidianCard,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: AppColors.obsidianBorder.withOpacity(0.5),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image and overlay information
          AspectRatio(
            aspectRatio: 0.92,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.obsidianElevated,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        color: AppColors.luxuryMuted,
                        size: 36,
                      ),
                    );
                  },
                ),

                // Dark gradient overlay
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x66000000),
                        Colors.transparent,
                        Color(0x55000000),
                        Color(0xF0000000),
                      ],
                      stops: [0.0, 0.38, 0.65, 1.0],
                    ),
                  ),
                ),

                // Product status badge
                Positioned(
                  top: 12,
                  left: 10,
                  child: _statusBadge(),
                ),

                // Remove from favorites
                Positioned(
                  top: 10,
                  right: 10,
                  child: Material(
                    color: const Color(0xCC101319),
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: onRemove,
                      customBorder: const CircleBorder(),
                      child: const SizedBox(
                        width: 36,
                        height: 36,
                        child: Icon(
                          Icons.favorite_border,
                          color: AppColors.ivory,
                          size: 19,
                        ),
                      ),
                    ),
                  ),
                ),

                // Product information
                Positioned(
                  left: 12,
                  right: 12,
                  bottom: 13,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${product.category} · ${product.badge1}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.provenanceBadge.copyWith(
                          color: AppColors.goldAccent,
                          fontSize: 9,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.cardHeading.copyWith(
                          color: AppColors.ivory,
                          fontSize: 22,
                          height: 1.05,
                          fontFamily: 'EB Garamond',
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        product.specsSummary,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.overlaySubSpec.copyWith(
                          color: AppColors.ivoryMuted,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.priceLabel.isEmpty
                                ? 'ESTIMATED VALUE'
                                : product.priceLabel.toUpperCase(),
                            style: AppStyles.priceLabel.copyWith(
                              color: AppColors.luxuryMuted,
                              fontSize: 8,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            product.price,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.priceValue.copyWith(
                              color: AppColors.ivory,
                              fontSize: 21,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        product.workshop,
                        textAlign: TextAlign.end,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.specItemLabel.copyWith(
                          color: AppColors.goldAccent,
                          fontSize: 8,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 42,
                        child: ElevatedButton.icon(
                          onPressed: onMoveToBag,
                          icon: const Icon(
                            Icons.shopping_bag_outlined,
                            size: 14,
                          ),
                          label: const Text('MOVE TO BAG'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.gold,
                            foregroundColor: AppColors.obsidianDark,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                            textStyle: AppStyles.primaryButtonText.copyWith(
                              fontSize: 9,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Material(
                      color: AppColors.obsidianElevated,
                      borderRadius: BorderRadius.circular(3),
                      child: InkWell(
                        onTap: onSecondaryAction,
                        borderRadius: BorderRadius.circular(3),
                        child: SizedBox(
                          width: 42,
                          height: 42,
                          child: Icon(
                            product.secondaryActionIcon,
                            color: AppColors.ivory,
                            size: 17,
                          ),
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
    );
  }

  Widget _statusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: AppColors.obsidianDark.withOpacity(0.88),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.obsidianBorder,
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: product.statusColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            product.status.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.goldLight,
              fontSize: 8,
              letterSpacing: 0.7,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
