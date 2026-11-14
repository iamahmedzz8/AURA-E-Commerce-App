import 'package:flutter/material.dart';
import 'package:aura_maison_e_commerce/features/admin/inventory/domain/entities/inventory_item.dart';
import '../../data/datasources/inventory_remote_data_source.dart';
import '../widgets/header_section.dart';
import '../widgets/stats_section.dart';
import '../widgets/action_buttons.dart';
import '../widgets/search_filter.dart';
import '../widgets/inventory_card.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final InventoryApiDataSource dataSource = InventoryApiDataSource();
  late Future<List<InventoryItem>> _futureItems;

  @override
  void initState() {
    super.initState();
    _futureItems = dataSource.fetchInventoryItems();
  }

  void _refresh() {
    setState(() {
      _futureItems = dataSource.fetchInventoryItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: FutureBuilder<List<InventoryItem>>(
          future: _futureItems,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.redAccent),
                ),
              );
            }
            final items = snapshot.data ?? [];
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  automaticallyImplyLeading: false,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  surfaceTintColor: Colors.transparent,
                  elevation: 0,
                  toolbarHeight: 80,
                  title: const HeaderSection(),
                ),
                const SliverToBoxAdapter(child: StatsSection()),
                SliverToBoxAdapter(child: ActionButtons(onAdd: _refresh)),
                const SliverToBoxAdapter(child: SearchFilter()),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                        InventoryCard(item: items[index], onDelete: _refresh),
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
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.copy,
                              size: 14,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'SIMULATE EMPTY INVENTORY STATE',
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.color,
                                fontSize: 10,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
