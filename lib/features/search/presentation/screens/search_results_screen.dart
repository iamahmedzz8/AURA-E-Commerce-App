import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/widgets/app_header.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/screens/no_results_screen.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/haute_horlogerie_grid.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/interactive_refinement_chips.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/salon_concierge_vitrine_bar.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/search_results_query_bar.dart';
import 'package:flutter/material.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: AppHeader(title: AppStrings.workshopCurationTitle),
            ),
            SliverToBoxAdapter(
              child: SearchResultsQueryBar(
                onSubmitted: (_) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NoResultsScreen(),
                    ),
                  );
                },
              ),
            ),
            const SliverToBoxAdapter(
              child: InteractiveRefinementChips(),
            ),
            const SliverToBoxAdapter(
              child: HauteHorlogerieGrid(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 12),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const SafeArea(
        top: false,
        child: SalonConciergeVitrineBar(),
      ),
    );
  }
}
