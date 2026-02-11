import 'package:app/features/events/domain/entities/event_entity.dart';
import 'package:app/features/events/domain/repositories/event_repository.dart';

class GetEventById {
  final EventRepository _repository;

  GetEventById(this._repository);

  Future<EventEntity?> call(String eventId) {
    return _repository.getEventById(eventId);
  }
}
