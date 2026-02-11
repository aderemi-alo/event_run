import 'package:app/features/events/domain/repositories/event_repository.dart';

class DeleteEvent {
  final EventRepository _repository;

  DeleteEvent(this._repository);

  Future<void> call(String eventId) {
    return _repository.deleteEvent(eventId);
  }
}
