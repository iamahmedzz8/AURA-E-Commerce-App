import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';

import '../widgets/add_product_app_bar.dart';
import '../widgets/add_product_title_section.dart';
import '../widgets/identity_section.dart';
import '../widgets/imagery_section.dart';
import '../widgets/notes_section.dart';
import '../widgets/specifications_section.dart';
import '../widgets/valuation_section.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkTheme.background,
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
              title: const AddProductAppBar(),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const AddProductTitleSection(),
                  const SizedBox(height: 24),
                  const ImagerySection(),
                  const SizedBox(height: 16),
                  IdentitySection(),
                  const SizedBox(height: 16),
                  ValuationSection(),
                  const SizedBox(height: 16),
                  const SpecificationsSection(),
                  const SizedBox(height: 16),
                  NotesSection(),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: DarkTheme.gold,
                        foregroundColor: DarkTheme.background,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      ),
                      onPressed: (){},
                      icon: const Icon(Icons.save_outlined, size: 18),
                      label: const Text('SAVE TO SOVEREIGN REGISTER', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1, fontFamily: 'Inter')),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel and return to inventory', style: TextStyle(color: DarkTheme.secondaryText, fontSize: 12, fontFamily: 'Inter')),
                    ),
                  ),
                  const SizedBox(height: 24),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}