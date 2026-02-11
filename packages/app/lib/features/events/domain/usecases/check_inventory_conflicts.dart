import 'package:app/features/events/domain/entities/inventory_conflict_entity.dart';
import 'package:app/features/events/domain/repositories/event_requirement_repository.dart';

class CheckInventoryConflicts {
  final EventRequirementRepository _repository;

  CheckInventoryConflicts(this._repository);

  Future<List<InventoryConflictEntity>> call(String eventId) {
    return _repository.checkConflicts(eventId);
  }
}
