import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:aura_maison_e_commerce/features/categories/data/models/product_item_model.dart';
import 'package:aura_maison_e_commerce/features/categories/presentation/widgets/product_card.dart';

import 'package:flutter/material.dart';

class ProductsListSection extends StatelessWidget {
  ProductsListSection({super.key});

  final List<ProductItemModel> sampleProducts = [
    // Product 1
    ProductItemModel(
      imageUrl:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?q=80&w=800',
      badge1: AppStrings.p1Badge1,
      badge2: AppStrings.p1Badge2,
      workshop: AppStrings.p1Workshop,
      specsSummary: AppStrings.p1SpecsSummary,
      status: AppStrings.p1Status,
      statusColor: AppColors.statusGreen,
      category: AppStrings.p1Category,
      title: AppStrings.p1Title,
      priceLabel: AppStrings.p1PriceLabel,
      price: AppStrings.p1Price,
      description: AppStrings.p1Description,
      specs: [
        SpecItem(
          label: AppStrings.p1Spec1Label,
          value: AppStrings.p1Spec1Value,
        ),
        SpecItem(
          label: AppStrings.p1Spec2Label,
          value: AppStrings.p1Spec2Value,
        ),
        SpecItem(
          label: AppStrings.p1Spec3Label,
          value: AppStrings.p1Spec3Value,
        ),
      ],
      actionLabel: AppStrings.p1ActionPrimary,
      secondaryActionIcon: Icons.calendar_month_outlined,
    ),
    // Product 2
    ProductItemModel(
      imageUrl:
          'https://images.unsplash.com/photo-1524805444758-089113d48a6d?q=80&w=800',
      badge1: AppStrings.p2Badge1,
      badge2: AppStrings.p2Badge2,
      workshop: AppStrings.p2Workshop,
      specsSummary: AppStrings.p2SpecsSummary,
      status: AppStrings.p2Status,
      statusColor: AppColors.goldAccent,
      category: AppStrings.p2Category,
      title: AppStrings.p2Title,
      priceLabel: AppStrings.p2PriceLabel,
      price: AppStrings.p2Price,
      description: AppStrings.p2Description,
      specs: [
        SpecItem(
          label: AppStrings.p2Spec1Label,
          value: AppStrings.p2Spec1Value,
        ),
        SpecItem(
          label: AppStrings.p2Spec2Label,
          value: AppStrings.p2Spec2Value,
        ),
        SpecItem(
          label: AppStrings.p2Spec3Label,
          value: AppStrings.p2Spec3Value,
        ),
      ],
      actionLabel: AppStrings.p2ActionPrimary,
      secondaryActionIcon: Icons.share_outlined,
    ),
    // Product 3
    ProductItemModel(
      imageUrl:
          'https://images.unsplash.com/photo-1605100804763-247f67b3557e?q=80&w=800',
      badge1: AppStrings.p3Badge1,
      badge2: AppStrings.p3Badge2,
      workshop: AppStrings.p3Workshop,
      specsSummary: AppStrings.p3SpecsSummary,
      status: AppStrings.p3Status,
      statusColor: AppColors.goldBright,
      category: AppStrings.p3Category,
      title: AppStrings.p3Title,
      priceLabel: AppStrings.p3PriceLabel,
      price: AppStrings.p3Price,
      description: AppStrings.p3Description,
      specs: [
        SpecItem(
          label: AppStrings.p3Spec1Label,
          value: AppStrings.p3Spec1Value,
        ),
        SpecItem(
          label: AppStrings.p3Spec2Label,
          value: AppStrings.p3Spec2Value,
        ),
        SpecItem(
          label: AppStrings.p3Spec3Label,
          value: AppStrings.p3Spec3Value,
        ),
      ],
      actionLabel: AppStrings.p3ActionPrimary,
      secondaryActionIcon: Icons.meeting_room_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Introduction Editorial Row
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.auto_awesome_outlined,
                        size: 15,
                        color: AppColors.goldAccent,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          AppStrings.streamHeading,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.streamSectionTitle.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  AppStrings.streamPagination,
                  style: AppStyles.streamPagination.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // Cards Stream
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sampleProducts.length,
            separatorBuilder: (_, _) => const SizedBox(height: 24),
            itemBuilder: (context, index) {
              return ProductCard(product: sampleProducts[index]);
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
