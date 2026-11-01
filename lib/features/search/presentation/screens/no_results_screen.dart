import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';
import 'package:aura_maison_e_commerce/core/utils/app_strings.dart';
import 'package:aura_maison_e_commerce/core/widgets/app_header.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/concierge_consultation_banner.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/curated_alternative_suggestions.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/empty_state_centerpiece.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/no_results_query_bar.dart';
import 'package:aura_maison_e_commerce/features/search/presentation/widgets/vault_showcase_section.dart';
import 'package:flutter/material.dart';

class NoResultsScreen extends StatelessWidget {
  const NoResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: AppHeader(title: AppStrings.noResultsTitle),
            ),
            const SliverToBoxAdapter(
              child: NoResultsQueryBar(),
            ),
            const SliverToBoxAdapter(
              child: CuratedAlternativeSuggestions(),
            ),
            SliverToBoxAdapter(
              child: EmptyStateCenterpiece(
                onClearSearch: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const SliverToBoxAdapter(
              child: VaultShowcaseSection(),
            ),
            const SliverToBoxAdapter(
              child: ConciergeConsultationBanner(),
            ),
          ],
        ),
      ),
    );
  }
}
