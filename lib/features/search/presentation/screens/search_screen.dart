import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/widgets/app_bottom_nav_bar.dart';
import 'package:aura_maison_e_commerce/core/widgets/app_header.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/screens/no_results_screen.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/screens/search_results_screen.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/curator_suggestions_section.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/recent_searches_widget.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/search_suite_widget.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/signature_collections_grid.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  void _handleSearch(BuildContext context, String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const NoResultsScreen(query: ""),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SearchResultsScreen(query: trimmed),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Fixed App Header
            const AppHeader(title: AppStrings.searchTitle),

            // Scrollable Content
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SearchSuiteWidget(
                      onSubmitted: (query) => _handleSearch(context, query),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: RecentSearchesWidget(
                      onItemSelected: (item) => _handleSearch(context, item),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SignatureCollectionsGrid(),
                  ),
                  SliverToBoxAdapter(
                    child: CuratorSuggestionsSection(
                      onItemTap: (item) => _handleSearch(context, item.title),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 1),
    );
  }
}
