import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/widgets/app_header.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/haute_horlogerie_grid.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/interactive_refinement_chips.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/salon_concierge_vitrine_bar.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/search_results_query_bar.dart';
import 'package:flutter/material.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: AppHeader(title: AppStrings.workshopCurationTitle),
            ),
            SliverToBoxAdapter(
              child: SearchResultsQueryBar(),
            ),
            SliverToBoxAdapter(
              child: InteractiveRefinementChips(),
            ),
            SliverToBoxAdapter(
              child: HauteHorlogerieGrid(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: SalonConciergeVitrineBar(),
      ),
    );
  }
}
