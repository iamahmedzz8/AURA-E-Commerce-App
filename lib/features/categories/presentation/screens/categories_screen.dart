import 'package:aura_maison_e_commerce/core/di/injection_container.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/widgets/app_header.dart';
import 'package:aura_maison_e_commerce/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:aura_maison_e_commerce/features/categories/presentation/widgets/bespoke_card.dart';
import 'package:aura_maison_e_commerce/features/categories/presentation/widgets/curated_section.dart';
import 'package:aura_maison_e_commerce/features/categories/presentation/widgets/filter_delegate.dart';
import 'package:aura_maison_e_commerce/features/categories/presentation/widgets/filter_section.dart';
import 'package:aura_maison_e_commerce/features/categories/presentation/widgets/products_list_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  final String? initialCategory;
  const CategoriesScreen({super.key, this.initialCategory});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoriesScreenCubit>(
      create: (_) => sl<CategoriesScreenCubit>()
        ..loadCategoriesAndProducts(initialCategoryName: initialCategory),
      child: const _CategoriesScreenContent(),
    );
  }
}

class _CategoriesScreenContent extends StatelessWidget {
  const _CategoriesScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const AppHeader(title: AppStrings.collectionsTitle),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: CuratedSection(),
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: FilterDelegate(
                      child: FilterSection(
                        onClearAll: () {
                          context
                              .read<CategoriesScreenCubit>()
                              .clearCategorySelection();
                        },
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: ProductsListSection()),
                  SliverToBoxAdapter(
                    child: BespokeCard(onSpecialOrderTap: () {}),
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
