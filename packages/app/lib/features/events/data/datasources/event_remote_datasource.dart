import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/core/constants/supabase_constants.dart';
import 'package:app/core/error/exceptions.dart';
import 'package:app/features/events/data/models/event_model.dart';

abstract class EventRemoteDatasource {
  Future<List<EventModel>> getEvents(String vendorId);
  Future<EventModel?> getEventById(String eventId);
  Future<EventModel> createEvent({required EventModel event});
  Future<EventModel> updateEvent({required EventModel event});
  Future<void> deleteEvent(String eventId);
  Future<List<EventModel>> getUpcomingEvents(String vendorId);
  Future<List<EventModel>> getEventsByClient(String clientId);
}

class EventRemoteDatasourceImpl implements EventRemoteDatasource {
  final SupabaseClient _client;

  EventRemoteDatasourceImpl(this._client);

  @override
  Future<List<EventModel>> getEvents(String vendorId) async {
    try {
      final response = await _client
          .from(SupabaseConstants.eventsTable)
          .select()
          .eq('vendor_id', vendorId)
          .order('event_date', ascending: false);

      return response.map((json) => EventModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<EventModel?> getEventById(String eventId) async {
    try {
      final response = await _client
          .from(SupabaseConstants.eventsTable)
          .select()
          .eq('id', eventId)
          .maybeSingle();

      if (response == null) return null;
      return EventModel.fromJson(response);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<EventModel> createEvent({required EventModel event}) async {
    try {
      final response = await _client
          .from(SupabaseConstants.eventsTable)
          .insert(event.toJson())
          .select()
          .single();

      return EventModel.fromJson(response);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<EventModel> updateEvent({required EventModel event}) async {
    try {
      final response = await _client
          .from(SupabaseConstants.eventsTable)
          .update(event.toJson())
          .eq('id', event.id)
          .select()
          .single();

      return EventModel.fromJson(response);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> deleteEvent(String eventId) async {
    try {
      await _client
          .from(SupabaseConstants.eventsTable)
          .delete()
          .eq('id', eventId);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<EventModel>> getUpcomingEvents(String vendorId) async {
    try {
      final response = await _client
          .from(SupabaseConstants.eventsTable)
          .select()
          .eq('vendor_id', vendorId)
          .eq('status', 'upcoming')
          .order('event_date');

      return response.map((json) => EventModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<EventModel>> getEventsByClient(String clientId) async {
    try {
      final response = await _client
          .from(SupabaseConstants.eventsTable)
          .select()
          .eq('client_id', clientId)
          .order('event_date', ascending: false);

      return response.map((json) => EventModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
