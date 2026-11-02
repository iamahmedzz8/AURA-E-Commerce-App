import '../../domain/entities/dashboard_stats.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardStats> fetchDashboardStats();
}

class MockDashboardRemoteDataSource implements DashboardRemoteDataSource {
  @override
  Future<DashboardStats> fetchDashboardStats() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return DashboardStats(
      totalEstimatedInventory: 4820000,
      listedMasterpieces: 48,
      approvedPieces: 32,
      reservedReservations: 12,
      outOfStock: 4,
    );
  }
}