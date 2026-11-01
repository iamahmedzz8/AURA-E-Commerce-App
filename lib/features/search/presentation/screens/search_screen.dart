import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/widgets/app_header.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/curator_suggestions_section.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/recent_searches_widget.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/search_suite_widget.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/signature_collections_grid.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: AppHeader(title: AppStrings.searchTitle),
            ),
            const SliverToBoxAdapter(
              child: SearchSuiteWidget(),
            ),
            const SliverToBoxAdapter(
              child: RecentSearchesWidget(),
            ),
            const SliverToBoxAdapter(
              child: SignatureCollectionsGrid(),
            ),
            const SliverToBoxAdapter(
              child: CuratorSuggestionsSection(),
            ),
          ],
        ),
      ),
    );
  }
}
