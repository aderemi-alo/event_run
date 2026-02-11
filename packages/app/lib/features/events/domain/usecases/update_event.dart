import 'package:app/features/events/domain/entities/event_entity.dart';
import 'package:app/features/events/domain/repositories/event_repository.dart';

class UpdateEvent {
  final EventRepository _repository;

  UpdateEvent(this._repository);

  Future<EventEntity> call({required EventEntity event}) {
    return _repository.updateEvent(event: event);
  }
}
