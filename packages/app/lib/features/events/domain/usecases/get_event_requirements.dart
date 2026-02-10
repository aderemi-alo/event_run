import 'package:event_run/features/events/domain/entities/event_requirement_entity.dart';
import 'package:event_run/features/events/domain/repositories/event_requirement_repository.dart';

class GetEventRequirements {
  final EventRequirementRepository _repository;

  GetEventRequirements(this._repository);

  Future<List<EventRequirementEntity>> call(String eventId) {
    return _repository.getRequirements(eventId);
  }
}
