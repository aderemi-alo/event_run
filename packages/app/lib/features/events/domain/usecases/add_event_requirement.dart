import 'package:app/features/events/domain/entities/event_requirement_entity.dart';
import 'package:app/features/events/domain/repositories/event_requirement_repository.dart';

class AddEventRequirement {
  final EventRequirementRepository _repository;

  AddEventRequirement(this._repository);

  Future<EventRequirementEntity> call({
    required EventRequirementEntity requirement,
  }) {
    return _repository.addRequirement(requirement: requirement);
  }
}
