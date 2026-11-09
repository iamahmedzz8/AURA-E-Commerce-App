import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:aura_maison_e_commerce/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:aura_maison_e_commerce/features/home/data/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CuratedSection extends StatelessWidget {
  const CuratedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesScreenCubit, CategoriesProductsState>(
      builder: (context, state) {
        final cubit = context.read<CategoriesScreenCubit>();
        final categories = cubit.categories;
        final selectedCategoryId = cubit.selectedCategoryId;
        final allProducts = cubit.allProducts;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Header Row
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.curatedDepartments,
                        style: AppStyles.sectionEyebrow.copyWith(
                          color: AppColors.goldAccent,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        AppStrings.privateWorkshops,
                        style: AppStyles.sectionHeading.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      categories.isNotEmpty
                          ? '${categories.length} CURATED MAISONS'
                          : AppStrings.rarePiecesCount,
                      style: AppStyles.sectionCount.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Horizontal Carousel
            if (state is CategoriesProductsLoadingState && categories.isEmpty)
              _buildLoadingCarousel()
            else if (categories.isEmpty)
              _buildEmptyPlaceholder()
            else
              SizedBox(
                height: 265,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length + 1, // First item is "ALL COLLECTIONS"
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      final isSelected = selectedCategoryId == null;
                      return _buildAllWorkshopCard(
                        context: context,
                        isSelected: isSelected,
                        totalPieces: allProducts.length,
                      );
                    }

                    final category = categories[index - 1];
                    final isSelected = selectedCategoryId == category.id;
                    final categoryProductCount = allProducts.where((p) {
                      final selId = category.id.trim().toLowerCase();
                      final selName = category.name.trim().toLowerCase();
                      return p.categories.any((c) {
                        final cTrimmed = c.trim().toLowerCase();
                        return cTrimmed == selId ||
                            cTrimmed == selName ||
                            cTrimmed.contains(selName);
                      });
                    }).length;

                    return _buildCategoryWorkshopCard(
                      context: context,
                      category: category,
                      isSelected: isSelected,
                      pieceCount: categoryProductCount,
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildAllWorkshopCard({
    required BuildContext context,
    required bool isSelected,
    required int totalPieces,
  }) {
    return GestureDetector(
      onTap: () => context.read<CategoriesScreenCubit>().getProductsByCategoryId(null),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 256,
        height: 265,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.cardActive : AppColors.cardInactive,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(color: AppColors.goldAccent.withValues(alpha: 0.5), width: 1)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              child: SizedBox(
                height: 176,
                width: double.infinity,
                child: Container(
                  color: const Color(0xFF161920),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      const Center(
                        child: Icon(
                          Icons.auto_awesome,
                          size: 48,
                          color: AppColors.goldAccent,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.badgeBackground,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '$totalPieces PIECES',
                            style: AppStyles.badgeText.copyWith(
                              color: isSelected ? AppColors.goldAccent : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (isSelected)
                        Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.only(right: 6),
                          decoration: const BoxDecoration(
                            color: AppColors.goldBright,
                            shape: BoxShape.circle,
                          ),
                        ),
                      Text(
                        'ALL CREATIONS',
                        style: AppStyles.cardTag.copyWith(
                          color: isSelected ? AppColors.goldAccent : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Full Collection',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.cardHeading.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Explore all curated pieces',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.cardSubtitle.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryWorkshopCard({
    required BuildContext context,
    required CategoryModel category,
    required bool isSelected,
    required int pieceCount,
  }) {
    return GestureDetector(
      onTap: () =>
          context.read<CategoriesScreenCubit>().getProductsByCategoryId(category.id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 256,
        height: 265,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.cardActive : AppColors.cardInactive,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(color: AppColors.goldAccent.withValues(alpha: 0.6), width: 1.2)
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Image Area
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              child: SizedBox(
                height: 176,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (category.coverPictureUrl.isNotEmpty)
                      Image.network(
                        category.coverPictureUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Container(
                          color: AppColors.cardInactive,
                          child: const Icon(
                            Icons.category_outlined,
                            color: AppColors.textSecondary,
                            size: 40,
                          ),
                        ),
                      )
                    else
                      Container(
                        color: AppColors.cardInactive,
                        child: const Icon(
                          Icons.category_outlined,
                          color: AppColors.textSecondary,
                          size: 40,
                        ),
                      ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            (isSelected ? AppColors.cardActive : AppColors.cardInactive)
                                .withValues(alpha: 0.6),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.badgeBackground,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '$pieceCount PIECES',
                          style: AppStyles.badgeText.copyWith(
                            color: isSelected ? AppColors.goldAccent : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Bottom Metadata Area
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      if (isSelected)
                        Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.only(right: 6),
                          decoration: const BoxDecoration(
                            color: AppColors.goldBright,
                            shape: BoxShape.circle,
                          ),
                        ),
                      Text(
                        category.name.toUpperCase(),
                        style: AppStyles.cardTag.copyWith(
                          color: isSelected ? AppColors.goldAccent : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.cardHeading.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category.description ?? 'Curated Haute Collection',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.cardSubtitle.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingCarousel() {
    return SizedBox(
      height: 265,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (_, __) => Container(
          width: 256,
          height: 265,
          decoration: BoxDecoration(
            color: AppColors.cardInactive,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.goldAccent,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyPlaceholder() {
    return const SizedBox(
      height: 120,
      child: Center(
        child: Text(
          'No categories available',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      ),
    );
  }
}
