import 'package:aura_maison_e_commerce/core/di/injection_container.dart';
import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/utils/app_styles.dart';
import 'package:aura_maison_e_commerce/features/categories/presentation/cubit/category_products_cubit.dart';
import 'package:aura_maison_e_commerce/features/categories/presentation/screens/category_products_screen.dart';
import 'package:aura_maison_e_commerce/features/home/data/models/category_model.dart';
import 'package:aura_maison_e_commerce/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A horizontally scrolling carousel of category cards.
///
/// When a card is tapped the user navigates to [CategoryProductsScreen] which
/// fetches products for that category from the real API using
/// [CategoryProductsCubit] → [HomeRemoteDataSource.getProductsByCategory].
class CuratedSection extends StatefulWidget {
  const CuratedSection({super.key});

  @override
  State<CuratedSection> createState() => _CuratedSectionState();
}

class _CuratedSectionState extends State<CuratedSection> {
  int selectedIndex = 0;

  void _onCategoryTap(BuildContext context, CategoryModel category, int index) {
    setState(() => selectedIndex = index);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider<CategoryProductsCubit>(
          create: (_) =>
              CategoryProductsCubit(remoteDataSource: sl())
                ..fetchByCategory(categoryName: category.name),
          child: CategoryProductsScreen(
            categoryName: category.name,
            categoryId: category.id,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoadingState) {
          return _buildLoadingCarousel();
        }

        if (state is CategoriesSuccessState && state.categories.isNotEmpty) {
          return _buildCarousel(context, state.categories);
        }

        if (state is CategoriesFailureState) {
          return _buildErrorState(state.errorMessage, context);
        }

        // Initial / empty state – show placeholder
        return _buildLoadingCarousel();
      },
    );
  }

  // ── Carousel with real categories ─────────────────────────────────────────

  Widget _buildCarousel(BuildContext context, List<CategoryModel> categories) {
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
              Expanded(
                child: Column(
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.sectionHeading.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  '${categories.length} collections',
                  style: AppStyles.sectionCount.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Horizontal Carousel
        SizedBox(
          height: 265,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = index == selectedIndex;
              return GestureDetector(
                onTap: () => _onCategoryTap(context, category, index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 256,
                  height: 265,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.cardActive
                        : AppColors.cardInactive,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Image Area
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(8),
                        ),
                        child: SizedBox(
                          height: 176,
                          width: double.infinity,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              category.coverPictureUrl.isNotEmpty
                                  ? Image.network(
                                      category.coverPictureUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, _, _) =>
                                          _placeholderImage(),
                                    )
                                  : _placeholderImage(),
                              // Bottom vignette gradient
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      (isSelected
                                              ? AppColors.cardActive
                                              : AppColors.cardInactive)
                                          .withValues(alpha: 0.6),
                                    ],
                                  ),
                                ),
                              ),
                              // Tap indicator overlay
                              Positioned.fill(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () => _onCategoryTap(
                                      context,
                                      category,
                                      index,
                                    ),
                                    splashColor: AppColors.goldAccent
                                        .withValues(alpha: 0.1),
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
                            // Category Tag + Active Indicator Dot
                            Row(
                              children: [
                                if (isSelected) ...[
                                  Container(
                                    width: 6,
                                    height: 6,
                                    margin: const EdgeInsets.only(right: 6),
                                    decoration: const BoxDecoration(
                                      color: AppColors.goldBright,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                                Text(
                                  category.name.toUpperCase(),
                                  style: AppStyles.cardTag.copyWith(
                                    color: isSelected
                                        ? AppColors.goldAccent
                                        : AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            // Category name as heading
                            Text(
                              category.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.cardHeading.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            // Description or fallback
                            Text(
                              category.description ??
                                  'Explore the collection →',
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
            },
          ),
        ),
      ],
    );
  }

  // ── Placeholder / Loading States ──────────────────────────────────────────

  Widget _placeholderImage() {
    return Container(
      color: AppColors.cardInactive,
      child: const Icon(Icons.image_outlined, color: AppColors.textSecondary),
    );
  }

  Widget _buildLoadingCarousel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: Column(
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
        ),
        SizedBox(
          height: 265,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (_, _) => Container(
              width: 256,
              height: 265,
              decoration: BoxDecoration(
                color: AppColors.cardInactive,
                borderRadius: BorderRadius.circular(8),
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
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(String message, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.curatedDepartments,
            style: AppStyles.sectionEyebrow.copyWith(
              color: AppColors.goldAccent,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message.isNotEmpty ? message : 'Unable to load collections.',
            style: AppStyles.cardSubtitle.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => context.read<CategoriesCubit>().fetchCategories(),
            child: Text(
              'Retry',
              style: AppStyles.cardTag.copyWith(color: AppColors.goldAccent),
            ),
          ),
        ],
      ),
    );
  }
}
