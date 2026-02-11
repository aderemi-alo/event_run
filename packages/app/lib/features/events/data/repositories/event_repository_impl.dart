import 'package:app/features/events/data/datasources/event_remote_datasource.dart';
import 'package:app/features/events/data/models/event_model.dart';
import 'package:app/features/events/domain/entities/event_entity.dart';
import 'package:app/features/events/domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  final EventRemoteDatasource _datasource;

  EventRepositoryImpl(this._datasource);

  @override
  Future<List<EventEntity>> getEvents(String vendorId) {
    return _datasource.getEvents(vendorId);
  }

  @override
  Future<EventEntity?> getEventById(String eventId) {
    return _datasource.getEventById(eventId);
  }

  @override
  Future<EventEntity> createEvent({required EventEntity event}) {
    final model = EventModel(
      id: event.id,
      vendorId: event.vendorId,
      clientId: event.clientId,
      name: event.name,
      eventDate: event.eventDate,
      location: event.location,
      status: event.status,
      revenue: event.revenue,
      notes: event.notes,
      createdAt: event.createdAt,
    );
    return _datasource.createEvent(event: model);
  }

  @override
  Future<EventEntity> updateEvent({required EventEntity event}) {
    final model = EventModel(
      id: event.id,
      vendorId: event.vendorId,
      clientId: event.clientId,
      name: event.name,
      eventDate: event.eventDate,
      location: event.location,
      status: event.status,
      revenue: event.revenue,
      notes: event.notes,
      createdAt: event.createdAt,
    );
    return _datasource.updateEvent(event: model);
  }

  @override
  Future<void> deleteEvent(String eventId) {
    return _datasource.deleteEvent(eventId);
  }

  @override
  Future<List<EventEntity>> getUpcomingEvents(String vendorId) {
    return _datasource.getUpcomingEvents(vendorId);
  }

  @override
  Future<List<EventEntity>> getEventsByClient(String clientId) {
    return _datasource.getEventsByClient(clientId);
  }
}
