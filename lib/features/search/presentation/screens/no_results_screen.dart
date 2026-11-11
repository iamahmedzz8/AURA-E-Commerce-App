import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/widgets/app_bottom_nav_bar.dart';
import 'package:aura_maison_e_commerce/core/widgets/app_header.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/screens/search_results_screen.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/concierge_consultation_banner.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/curated_alternative_suggestions.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/empty_state_centerpiece.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/no_results_query_bar.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/vault_showcase_section.dart';
import 'package:flutter/material.dart';

class NoResultsScreen extends StatelessWidget {
  final String? query;

  const NoResultsScreen({super.key, this.query});

  void _handleSearch(BuildContext context, String newQuery) {
    final trimmed = newQuery.trim();
    if (trimmed.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SearchResultsScreen(query: trimmed)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Fixed App Header
            const AppHeader(title: AppStrings.noResultsTitle),

            // Scrollable Empty State Content
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: NoResultsQueryBar(
                      initialQuery: query,
                      onSubmitted: (newQuery) =>
                          _handleSearch(context, newQuery),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: CuratedAlternativeSuggestions(
                      onSuggestionTap: (suggestion) =>
                          _handleSearch(context, suggestion),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: EmptyStateCenterpiece(
                      onClearSearch: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SliverToBoxAdapter(child: VaultShowcaseSection()),
                  const SliverToBoxAdapter(
                    child: ConciergeConsultationBanner(),
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
