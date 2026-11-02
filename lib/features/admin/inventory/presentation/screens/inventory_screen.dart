import 'package:aura_maison_e_commerce/core/theme/dark_theme.dart';
import 'package:aura_maison_e_commerce/features/admin/inventory/domain/entities/inventory_entity.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/dark_theme.dart';
import '../../domain/entities/inventory_item.dart';
import '../../data/datasources/inventory_remote_data_source.dart';
import '../widgets/header_section.dart';
import '../widgets/stats_section.dart';
import '../widgets/action_buttons.dart';
import '../widgets/search_filter.dart';
import '../widgets/inventory_card.dart';
import '../widgets/custom_bottom_nav.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dataSource = MockInventoryRemoteDataSource();

    return Scaffold(
      backgroundColor: DarkTheme.background,
      body: SafeArea(
        child: FutureBuilder<List<InventoryItem>>(
          future: dataSource.fetchInventoryItems(),
          builder: (context, snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: DarkTheme.gold),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(color: Colors.redAccent),
                ),
              );
            }

            final items = snapshot.data ?? [];

            return CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: HeaderSection()),
                const SliverToBoxAdapter(child: StatsSection()),
                const SliverToBoxAdapter(child: ActionButtons()),
                const SliverToBoxAdapter(child: SearchFilter()),

                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) => InventoryCard(item: items[index]),
                    childCount: items.length,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Column(
                      children: [
                        Text(
                          'Showing ${items.length} of 48 listed masterpieces',
                          style: TextStyle(color: DarkTheme.secondaryText, fontSize: 12),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.copy, size: 14, color: DarkTheme.secondaryText),
                            const SizedBox(width: 4),
                            Text(
                              'SIMULATE EMPTY INVENTORY STATE',
                              style: TextStyle(color: DarkTheme.secondaryText, fontSize: 10, letterSpacing: 1),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}
