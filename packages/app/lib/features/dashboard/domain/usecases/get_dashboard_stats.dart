import 'package:event_run/features/dashboard/domain/entities/dashboard_stats_entity.dart';
import 'package:event_run/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetDashboardStats {
  final DashboardRepository repository;

  const GetDashboardStats(this.repository);

  Future<DashboardStatsEntity> call(String vendorId) {
    return repository.getDashboardStats(vendorId);
  }
}
