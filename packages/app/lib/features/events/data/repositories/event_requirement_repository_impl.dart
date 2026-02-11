import 'package:app/features/events/data/datasources/event_requirement_remote_datasource.dart';
import 'package:app/features/events/data/models/event_requirement_model.dart';
import 'package:app/features/events/domain/entities/event_requirement_entity.dart';
import 'package:app/features/events/domain/entities/inventory_conflict_entity.dart';
import 'package:app/features/events/domain/repositories/event_requirement_repository.dart';

class EventRequirementRepositoryImpl implements EventRequirementRepository {
  final EventRequirementRemoteDatasource _datasource;

  EventRequirementRepositoryImpl(this._datasource);

  @override
  Future<List<EventRequirementEntity>> getRequirements(String eventId) {
    return _datasource.getRequirements(eventId);
  }

  @override
  Future<EventRequirementEntity> addRequirement({
    required EventRequirementEntity requirement,
  }) {
    final model = EventRequirementModel(
      id: requirement.id,
      eventId: requirement.eventId,
      inventoryItemId: requirement.inventoryItemId,
      quantity: requirement.quantity,
      notes: requirement.notes,
      createdAt: requirement.createdAt,
    );
    return _datasource.addRequirement(requirement: model);
  }

  @override
  Future<EventRequirementEntity> updateRequirement({
    required EventRequirementEntity requirement,
  }) {
    final model = EventRequirementModel(
      id: requirement.id,
      eventId: requirement.eventId,
      inventoryItemId: requirement.inventoryItemId,
      quantity: requirement.quantity,
      notes: requirement.notes,
      createdAt: requirement.createdAt,
    );
    return _datasource.updateRequirement(requirement: model);
  }

  @override
  Future<void> removeRequirement(String requirementId) {
    return _datasource.removeRequirement(requirementId);
  }

  @override
  Future<List<InventoryConflictEntity>> checkConflicts(String eventId) {
    return _datasource.checkConflicts(eventId);
  }
}
