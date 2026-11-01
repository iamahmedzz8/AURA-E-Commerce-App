import 'package:aura_maison/core/utils/app_colors.dart';
import 'package:aura_maison/core/utils/app_styles.dart';
import 'package:aura_maison/features/categories/data/models/product_item_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {super.key,
      required this.product,
      this.onPrimaryAction,
      this.onSecondaryAction});

  final ProductItemModel product;
  final VoidCallback? onPrimaryAction;
  final VoidCallback? onSecondaryAction;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isWishlisted = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardInactive,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Top Image Showcase (438px height)
          SizedBox(
            height: 438,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Product Photography
                Image.network(
                  p.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: AppColors.background,
                    child: const Icon(
                      Icons.image_outlined,
                      size: 48,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                // Top-Left: Provenance Badges
                Positioned(
                  top: 12,
                  left: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.badgeBackground,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          p.badge1,
                          style: AppStyles.provenanceBadge.copyWith(
                            color: AppColors.goldBright,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.badgeBackground,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          p.badge2,
                          style: AppStyles.provenanceBadge.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Top-Right: Wishlist Button
                Positioned(
                  top: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isWishlisted = !isWishlisted;
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.badgeBackground,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        isWishlisted
                            ? Icons.bookmark_rounded
                            : Icons.bookmark_border_rounded,
                        size: 18,
                        color: isWishlisted
                            ? AppColors.goldBright
                            : AppColors.iconLight,
                      ),
                    ),
                  ),
                ),
                // Bottom Floating Spec Overlay
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppColors.imageOverlayGradient
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Atelier & Calibre Specs
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                p.workshop,
                                style: AppStyles.overlayAtelier.copyWith(
                                  color: AppColors.goldAccent,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                p.specsSummary,
                                style: AppStyles.overlaySubSpec.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Status Badge (e.g. IN SALON)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.badgeBackground,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Text(
                            p.status,
                            style: AppStyles.overlayStatus.copyWith(
                              color: p.statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 2. Card Content Body
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category + Title + Price Block
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category & Title
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.category,
                            style: AppStyles.productCategory.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            p.title,
                            style: AppStyles.productTitle.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Price Block
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          p.priceLabel,
                          style: AppStyles.priceLabel.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          p.price,
                          style: AppStyles.priceValue.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Editorial Description
                Text(
                  p.description,
                  style: AppStyles.productDescription.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 14),
                // 3. Vitrine Specs Strip (3 columns)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.specsStripBackground,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: p.specs.asMap().entries.map((entry) {
                      final i = entry.key;
                      final s = entry.value;
                      return Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            border: i < p.specs.length - 1
                                ? const Border(
                                    right: BorderSide(
                                      color: Color(0x268A8F98),
                                      width: 1,
                                    ),
                                  )
                                : null,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                s.label,
                                style: AppStyles.specItemLabel.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                s.value,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppStyles.specItemValue.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),
                // 4. Action Row (Primary CTA + Secondary Tool)
                Row(
                  children: [
                    // Primary CTA (e.g. RESERVE ACQUISITION)
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: widget.onPrimaryAction ?? () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.goldAccent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Text(
                            p.actionLabel,
                            style: AppStyles.primaryButtonText.copyWith(
                              color: AppColors.iconDark,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Secondary Action (Appointment / Dossier)
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.buttonDarkBackground,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: IconButton(
                        icon: Icon(
                          p.secondaryActionIcon,
                          size: 18,
                          color: AppColors.goldAccent,
                        ),
                        onPressed: widget.onSecondaryAction ?? () {},
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
