import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:aura_maison_e_commerce/features/categories/presentation/cubit/category_products_cubit.dart';
import 'package:aura_maison_e_commerce/features/home/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Screen that displays all products belonging to a specific category.
///
/// Expects a [CategoryProductsCubit] to already be provided above it in the
/// widget tree (the [CategoriesScreen] creates it before navigating here).
class CategoryProductsScreen extends StatelessWidget {
  final String categoryName;
  final String? categoryId;

  const CategoryProductsScreen({
    super.key,
    required this.categoryName,
    this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AppBar(categoryName: categoryName),
            Expanded(
              child: BlocBuilder<CategoryProductsCubit, CategoryProductsState>(
                builder: (context, state) {
                  if (state is CategoryProductsLoading) {
                    return const _LoadingGrid();
                  }

                  if (state is CategoryProductsSuccess) {
                    return _ProductGrid(products: state.products);
                  }

                  if (state is CategoryProductsEmpty) {
                    return _EmptyState(categoryName: state.categoryName);
                  }

                  if (state is CategoryProductsFailure) {
                    return _ErrorState(
                      message: state.errorMessage,
                      onRetry: () => context
                          .read<CategoryProductsCubit>()
                          .fetchByCategory(categoryName: categoryName),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── App Bar ──────────────────────────────────────────────────────────────────

class _AppBar extends StatelessWidget {
  final String categoryName;
  const _AppBar({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.cardInactive,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 16,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'COLLECTION',
                  style: AppStyles.sectionEyebrow.copyWith(
                    color: AppColors.goldAccent,
                    fontSize: 9,
                    letterSpacing: 1.6,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  categoryName.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.sectionHeading.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 18,
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

// ── Product Grid ─────────────────────────────────────────────────────────────

class _ProductGrid extends StatelessWidget {
  final List<ProductModel> products;
  const _ProductGrid({required this.products});

  static const Color gold = Color(0xFFC5A059);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 14,
        childAspectRatio: 0.62,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) => _ProductCard(product: products[index]),
    );
  }
}

// ── Product Card ─────────────────────────────────────────────────────────────

class _ProductCard extends StatefulWidget {
  final ProductModel product;
  const _ProductCard({required this.product});

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  bool _wishlisted = false;

  static const Color _gold = Color(0xFFC5A059);

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? const Color(0xFF191C21) : Colors.white;
    final foreground = isDark ? Colors.white : const Color(0xFF171717);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Cover image
                Image.network(
                  p.coverPictureUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: const Color(0xFF191C21),
                    child: const Icon(
                      Icons.image_outlined,
                      color: Color(0xFF8A8F98),
                    ),
                  ),
                ),
                // Discount badge
                if (p.discountPercentage > 0)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      color: _gold,
                      child: Text(
                        '-${p.discountPercentage}%',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                // Wishlist button
                Positioned(
                  top: 7,
                  right: 7,
                  child: GestureDetector(
                    onTap: () => setState(() => _wishlisted = !_wishlisted),
                    child: Icon(
                      _wishlisted
                          ? Icons.bookmark_rounded
                          : Icons.bookmark_border_rounded,
                      color: _wishlisted ? _gold : foreground,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category label
                if (p.categories.isNotEmpty)
                  Text(
                    p.categories.first.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: _gold,
                      fontSize: 8,
                      fontFamily: 'Inter',
                      letterSpacing: 0.6,
                    ),
                  ),
                const SizedBox(height: 4),
                // Product name
                Text(
                  p.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: foreground,
                    fontSize: 13,
                    fontFamily: 'EB Garamond',
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                // Price
                Text(
                  '\$${p.price.toStringAsFixed(0)}',
                  style: TextStyle(
                    color: foreground,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 8),
                // Reserve CTA
                SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: foreground,
                      side: const BorderSide(color: _gold),
                      padding: EdgeInsets.zero,
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: const Text(
                      'RESERVE',
                      style: TextStyle(fontSize: 9, fontFamily: 'Inter'),
                    ),
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

// ── Loading State ─────────────────────────────────────────────────────────────

class _LoadingGrid extends StatelessWidget {
  const _LoadingGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 14,
        childAspectRatio: 0.62,
      ),
      itemCount: 6,
      itemBuilder: (_, __) => Container(
        decoration: BoxDecoration(
          color: AppColors.cardInactive,
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.goldAccent,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Empty State ───────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  final String categoryName;
  const _EmptyState({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.inventory_2_outlined,
              color: AppColors.goldAccent,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'No pieces found',
              style: AppStyles.sectionHeading.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'No items are available in the\n"$categoryName" collection at this time.',
              textAlign: TextAlign.center,
              style: AppStyles.cardSubtitle.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Error State ───────────────────────────────────────────────────────────────

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              color: AppColors.goldAccent,
              size: 40,
            ),
            const SizedBox(height: 14),
            Text(
              message.isNotEmpty ? message : 'Failed to load collection.',
              textAlign: TextAlign.center,
              style: AppStyles.cardSubtitle.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: onRetry,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.goldAccent),
                foregroundColor: AppColors.goldAccent,
              ),
              child: const Text('RETRY'),
            ),
          ],
        ),
      ),
    );
  }
}
