import 'package:event_run/features/events/domain/entities/event_entity.dart';
import 'package:event_run/features/events/domain/repositories/event_repository.dart';

class CreateEvent {
  final EventRepository _repository;

  CreateEvent(this._repository);

  Future<EventEntity> call({required EventEntity event}) {
    return _repository.createEvent(event: event);
  }
}
