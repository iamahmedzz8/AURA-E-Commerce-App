
import 'package:aura_maison_e_commerce/features/favorites/presentation/widgets/favorites_conciergeSection.dart';
import 'package:aura_maison_e_commerce/features/favorites/presentation/widgets/favorites_manager.dart';
import 'package:aura_maison_e_commerce/features/favorites/presentation/widgets/favotrite_notice.dart';
import 'package:flutter/material.dart';

import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/widgets/app_header.dart';

import 'package:aura_maison_e_commerce/features/categories/data/models/product_item_model.dart';
import 'package:aura_maison_e_commerce/features/categories/presentation/widgets/products_list_section.dart';

import '../widgets/favorite_product_card.dart';
import '../widgets/favorites_header_section.dart';

import '../widgets/empty_favorites_state.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late List<ProductItemModel> favoriteProducts;

  @override
  @override
void initState() {
  super.initState();

  favoriteProducts = List<ProductItemModel>.from(
    ProductsListSection().sampleProducts,
  );
}

  void removeFavorite(int index) {
    setState(() {
      favoriteProducts.removeAt(index);
    });

    _showMessage('Removed from your favorites');
  }

  void moveToBag(int index) {
    setState(() {
      favoriteProducts.removeAt(index);
    });

    _showMessage('Product moved to bag');
  }

  void transferAll() {
    if (favoriteProducts.isEmpty) return;

    setState(() {
      favoriteProducts.clear();
    });

    _showMessage('All products transferred');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.obsidianElevated,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  String calculateTotal() {
    double total = 0;

    for (final product in favoriteProducts) {
      final cleanPrice = product.price.replaceAll(
        RegExp(r'[^0-9.]'),
        '',
      );

      total += double.tryParse(cleanPrice) ?? 0;
    }

    final formatted = total
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => ',',
        );

    return '$formatted €';
  }

  void handleManage() {
    _showMessage('Manage favorites');
  }

  void handleExplore() {
    _showMessage('Explore workshop collections');
  }

  void handleAllocations() {
    _showMessage('View rare allocations');
  }

  void handleScheduleVisit() {
    _showMessage('Private visit request');
  }

  Widget buildFavoritesContent(double width) {
    final isTablet = width >= 700;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: FavoritesHeaderSection(
            itemCount: favoriteProducts.length,
          ),
        ),

        SliverToBoxAdapter(
          child: FavoritesManageBar(
            itemCount: favoriteProducts.length,
            onManage: handleManage,
            onTransferAll: transferAll,
          ),
        ),

        const SliverToBoxAdapter(
          child: FavoritesNotice(),
        ),

        if (isTablet)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return FavoriteProductCard(
                    product: favoriteProducts[index],
                    onRemove: () => removeFavorite(index),
                    onMoveToBag: () => moveToBag(index),
                  );
                },
                childCount: favoriteProducts.length,
              ),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 20,
                childAspectRatio: 0.58,
              ),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: FavoriteProductCard(
                      product: favoriteProducts[index],
                      onRemove: () => removeFavorite(index),
                      onMoveToBag: () => moveToBag(index),
                    ),
                  );
                },
                childCount: favoriteProducts.length,
              ),
            ),
          ),

        SliverToBoxAdapter(
          child: FavoritesConciergeSection(
            totalValue: calculateTotal(),
            onScheduleVisit: handleScheduleVisit,
          ),
        ),

        const SliverToBoxAdapter(
          child: SizedBox(height: 20),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.obsidian,
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(
              title: 'Vault Acquisitions',
              showBrand: true,
              showSearch: true,
              showNotifications: true,
            ),

            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (favoriteProducts.isEmpty) {
                    return EmptyFavoritesState(
                      onExploreCollections: handleExplore,
                      onViewAllocations: handleAllocations,
                    );
                  }

                  return buildFavoritesContent(
                    constraints.maxWidth,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
