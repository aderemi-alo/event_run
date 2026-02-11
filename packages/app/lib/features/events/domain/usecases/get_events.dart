import 'package:app/features/events/domain/entities/event_entity.dart';
import 'package:app/features/events/domain/repositories/event_repository.dart';

class GetEvents {
  final EventRepository _repository;

  GetEvents(this._repository);

  Future<List<EventEntity>> call(String vendorId) {
    return _repository.getEvents(vendorId);
  }
}
