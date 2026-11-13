import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/dark_theme.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../products/products/presentation/cubit/products_cubit.dart';
import '../widgets/ delete_action_buttons.dart';
import '../widgets/declassification_effects_list.dart';
import '../widgets/delete_app_bar.dart';
import '../widgets/delete_hero_section.dart';
import '../widgets/irreversible_protocol_card.dart';
import '../widgets/piece_summary_card.dart';
import '../widgets/sealing_code_input.dart';

class DeleteProductScreen extends StatelessWidget {
  final String productId;

  const DeleteProductScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: DarkTheme.background,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 85,
              title: const DeleteAppBar(),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const IrreversibleProtocolCard(),
                  const SizedBox(height: 24),
                  const DeleteHeroSection(),
                  const SizedBox(height: 24),
                  const PieceSummaryCard(),
                  const SizedBox(height: 24),
                  const DeclassificationEffectsList(),
                  const SizedBox(height: 24),
                  const SealingCodeInput(),
                  const SizedBox(height: 24),
                  BlocListener<ProductsCubit, ProductsState>(
                    listener: (context, state) {
                      if (state is DeleteProductSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(AppStrings.productDeletedSuccess),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pop(context, true);
                      } else if (state is DeleteProductFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: DeleteActionButtons(productId: productId),
                  ),
                  const SizedBox(height: 40),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
