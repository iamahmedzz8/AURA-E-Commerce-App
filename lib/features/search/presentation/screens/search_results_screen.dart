import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/widgets/app_bottom_nav_bar.dart';
import 'package:aura_maison_e_commerce/core/widgets/app_header.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/screens/no_results_screen.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/haute_horlogerie_grid.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/interactive_refinement_chips.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/salon_concierge_vitrine_bar.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/search_results_query_bar.dart';
import 'package:flutter/material.dart';

class SearchResultsScreen extends StatelessWidget {
  final String? query;

  const SearchResultsScreen({super.key, this.query});

  void _handleSearch(BuildContext context, String newQuery) {
    final trimmed = newQuery.trim();
    if (trimmed.isEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const NoResultsScreen(query: ""),
        ),
      );
    } else {
      Navigator.pushReplacement(
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Fixed App Header
            const AppHeader(title: AppStrings.workshopCurationTitle),

            // Scrollable Search Results Content
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SearchResultsQueryBar(
                      initialQuery: query,
                      onSubmitted: (newQuery) => _handleSearch(context, newQuery),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: InteractiveRefinementChips(),
                  ),
                  const SliverToBoxAdapter(
                    child: HauteHorlogerieGrid(),
                  ),
                  const SliverToBoxAdapter(
                    child: SalonConciergeVitrineBar(),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 16),
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
