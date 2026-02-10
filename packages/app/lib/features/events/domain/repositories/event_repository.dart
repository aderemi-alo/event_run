import 'package:event_run/features/events/domain/entities/event_entity.dart';

abstract class EventRepository {
  Future<List<EventEntity>> getEvents(String vendorId);
  Future<EventEntity?> getEventById(String eventId);
  Future<EventEntity> createEvent({required EventEntity event});
  Future<EventEntity> updateEvent({required EventEntity event});
  Future<void> deleteEvent(String eventId);
  Future<List<EventEntity>> getUpcomingEvents(String vendorId);
  Future<List<EventEntity>> getEventsByClient(String clientId);
}
