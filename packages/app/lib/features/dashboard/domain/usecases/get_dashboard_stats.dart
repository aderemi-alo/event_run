import 'package:app/features/dashboard/domain/entities/dashboard_stats_entity.dart';
import 'package:app/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetDashboardStats {
  final DashboardRepository repository;

  const GetDashboardStats(this.repository);

  Future<DashboardStatsEntity> call(String vendorId) {
    return repository.getDashboardStats(vendorId);
  }
}
