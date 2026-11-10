import 'package:aura_maison_e_commerce/core/di/injection_container.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/widgets/app_header.dart';
import 'package:aura_maison_e_commerce/features/categories/presentation/widgets/bespoke_card.dart';
import 'package:aura_maison_e_commerce/features/categories/presentation/widgets/curated_section.dart';
import 'package:aura_maison_e_commerce/features/categories/presentation/widgets/filter_delegate.dart';
import 'package:aura_maison_e_commerce/features/categories/presentation/widgets/filter_section.dart';
import 'package:aura_maison_e_commerce/features/categories/presentation/widgets/products_list_section.dart';
import 'package:aura_maison_e_commerce/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Provide CategoriesCubit so that CuratedSection can read real categories
    // from the API and navigate to CategoryProductsScreen on tap.
    return BlocProvider<CategoriesCubit>(
      create: (_) => sl<CategoriesCubit>()..fetchCategories(),
      child: Scaffold(
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
                      delegate: FilterDelegate(child: const FilterSection()),
                    ),
                    SliverToBoxAdapter(child: ProductsListSection()),
                    SliverToBoxAdapter(
                      child: BespokeCard(onSpecialOrderTap: () {}),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
