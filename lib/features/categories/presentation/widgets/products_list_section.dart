import 'package:aura_maison_e_commerce/core/di/injection_container.dart';
import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:aura_maison_e_commerce/features/cart/presentaion/cubit/cart_cubit.dart';
import 'package:aura_maison_e_commerce/features/categories/data/models/product_item_model.dart';
import 'package:aura_maison_e_commerce/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:aura_maison_e_commerce/features/categories/presentation/widgets/product_card.dart';
import 'package:aura_maison_e_commerce/features/home/data/models/product_model.dart';
import 'package:aura_maison_e_commerce/features/products/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:aura_maison_e_commerce/features/products/product_details/presentation/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsListSection extends StatelessWidget {
  const ProductsListSection({super.key});

  List<ProductItemModel> get sampleProducts => [
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

  void _navigateToProductDetails(BuildContext context, ProductModel product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider<CartCubit>(
              create: (_) => sl<CartCubit>(),
            ),
            BlocProvider<ProductDetailsCubit>(
              create: (_) =>
                  ProductDetailsCubit()..getProductsDetails(product.id),
            ),
          ],
          child: ProductDetailsScreen(
            productId: product.id,
            product: {
              'id': product.id,
              'name': product.name,
              'category': product.categories.isNotEmpty
                  ? product.categories.first.toUpperCase()
                  : 'LUXURY CREATION',
              'price': '${product.price.toInt()} EGP',
              'description': product.description ?? '',
              'rating': product.rating > 0
                  ? product.rating.toStringAsFixed(1)
                  : '5.0',
              'image': product.coverPictureUrl,
              'tag': product.color.isNotEmpty
                  ? product.color.toUpperCase()
                  : (product.discountPercentage > 0
                      ? '${product.discountPercentage}% OFF'
                      : 'EXCLUSIVE'),
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesScreenCubit, CategoriesProductsState>(
      builder: (context, state) {
        if (state is CategoriesProductsLoadingState) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.goldAccent,
                strokeWidth: 2,
              ),
            ),
          );
        }

        if (state is CategoriesProductsFailureState) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Center(
              child: Column(
                children: [
                  Text(
                    state.errorMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => context
                        .read<CategoriesScreenCubit>()
                        .loadCategoriesAndProducts(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.goldAccent,
                    ),
                    child: const Text('RETRY', style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),
          );
        }

        final cubit = context.read<CategoriesScreenCubit>();
        final products = state is CategoriesProductsSuccessState
            ? state.products
            : <ProductModel>[];
        final selectedId = state is CategoriesProductsSuccessState
            ? state.selectedCategoryId
            : cubit.selectedCategoryId;

        final selectedCat = cubit.categories.cast<dynamic>().firstWhere(
              (c) => c.id == selectedId,
              orElse: () => null,
            );

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
                          Flexible(
                            child: Text(
                              selectedCat != null
                                  ? selectedCat.name.toUpperCase()
                                  : AppStrings.streamHeading,
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
                    Text(
                      '${products.length} ${products.length == 1 ? "PIECE" : "PIECES"}',
                      style: AppStyles.streamPagination.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              if (products.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20),
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: AppColors.cardInactive,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.inventory_2_outlined,
                        size: 40,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        selectedCat != null
                            ? 'No pieces found in "${selectedCat.name}"'
                            : 'No pieces available at this time',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                )
              else
                // Cards Stream
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 24),
                  itemBuilder: (context, index) {
                    final productModel = products[index];
                    final productItem =
                        ProductItemModel.fromProductModel(productModel);

                    return ProductCard(
                      product: productItem,
                      onPrimaryAction: () =>
                          _navigateToProductDetails(context, productModel),
                    );
                  },
                ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
}
