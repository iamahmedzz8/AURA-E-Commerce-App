import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';
import '../widgets/action_buttons.dart';
import '../widgets/edit_app_bar.dart';
import '../widgets/gallery_section.dart';
import '../widgets/piece_identity_card.dart';
import '../widgets/protocol_validation_card.dart';
import '../widgets/restoration_notes_card.dart';
import '../widgets/service_register_card.dart';
import '../widgets/technical_specs_card.dart';
import '../widgets/valuation_card.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

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
              title: const EditAppBar(),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const RestorationNotesCard(),
                  const SizedBox(height: 16),
                  const ProtocolValidationCard(),
                  const SizedBox(height: 24),
                  const GallerySection(),
                  const SizedBox(height: 24),
                  const PieceIdentityCard(),
                  const SizedBox(height: 24),
                  const ValuationCard(),
                  const SizedBox(height: 24),
                  const TechnicalSpecsCard(),
                  const SizedBox(height: 24),
                  const ServiceRegisterCard(),
                  const SizedBox(height: 32),
                  const EditActionButtons(),
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
