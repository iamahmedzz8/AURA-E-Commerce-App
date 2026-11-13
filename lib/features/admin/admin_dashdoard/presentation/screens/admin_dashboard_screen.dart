import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';

import '../../domain/entities/dashboard_stats.dart';
import '../../data/datasources/dashboard_remote_data_source.dart';

import '../widgets/admin_header.dart';
import '../widgets/dashboard_title_and_status.dart';
import '../widgets/metrics_card.dart';
import '../widgets/quick_actions.dart';
import '../widgets/recent_register.dart';
import '../widgets/footer_note.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  late final DashboardRemoteDataSource _dataSource;

  DashboardStats? _stats;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _dataSource = MockDashboardRemoteDataSource();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final stats = await _dataSource.fetchDashboardStats();
      if (mounted) {
        setState(() {
          _stats = stats;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: DarkTheme.gold),
              )
            : CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    automaticallyImplyLeading: false,
                    backgroundColor: DarkTheme.background,
                    surfaceTintColor: Colors.transparent,
                    elevation: 0,
                    toolbarHeight: 80,
                    title: const AdminHeader(),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        const SizedBox(height: 16),
                        DashboardTitleAndStatus(
                          totalValue: _formatCurrency(
                            _stats!.totalEstimatedInventory,
                          ),
                        ),
                        const SizedBox(height: 20),
                        MetricsGridSection(
                          listed: _stats!.listedMasterpieces,
                          approved: _stats!.approvedPieces,
                          reserved: _stats!.reservedReservations,
                          outOfStock: _stats!.outOfStock,
                        ),
                        const SizedBox(height: 24),
                        const QuickActions(),
                        const SizedBox(height: 16),
                        const RecentRegister(),
                        const SizedBox(height: 16),
                        const FooterNote(),
                        const SizedBox(height: 40),
                      ]),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  String _formatCurrency(double value) {
    final str = value.toStringAsFixed(0);
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buffer.write(' ');
      buffer.write(str[i]);
    }
    return '${buffer.toString()} €';
  }
}
