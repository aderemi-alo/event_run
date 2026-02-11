import 'package:app/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:app/features/events/domain/entities/event_entity.dart';

class GetUpcomingEvents {
  final DashboardRepository repository;

  const GetUpcomingEvents(this.repository);

  Future<List<EventEntity>> call(String vendorId) {
    return repository.getUpcomingEvents(vendorId);
  }
}
