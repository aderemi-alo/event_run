import 'package:app/features/events/domain/entities/event_requirement_entity.dart';
import 'package:app/features/events/domain/entities/inventory_conflict_entity.dart';

abstract class EventRequirementRepository {
  Future<List<EventRequirementEntity>> getRequirements(String eventId);
  Future<EventRequirementEntity> addRequirement({
    required EventRequirementEntity requirement,
  });
  Future<EventRequirementEntity> updateRequirement({
    required EventRequirementEntity requirement,
  });
  Future<void> removeRequirement(String requirementId);
  Future<List<InventoryConflictEntity>> checkConflicts(String eventId);
}
