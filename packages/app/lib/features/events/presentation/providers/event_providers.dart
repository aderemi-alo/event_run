import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/features/events/data/datasources/event_remote_datasource.dart';
import 'package:app/features/events/data/repositories/event_repository_impl.dart';
import 'package:app/features/events/domain/entities/event_entity.dart';
import 'package:app/features/events/domain/repositories/event_repository.dart';
import 'package:app/features/events/domain/usecases/get_events.dart';
import 'package:app/features/events/domain/usecases/get_event_by_id.dart';
import 'package:app/features/events/domain/usecases/create_event.dart';
import 'package:app/features/events/domain/usecases/update_event.dart';
import 'package:app/features/events/domain/usecases/delete_event.dart';

// Datasource
final eventRemoteDatasourceProvider = Provider<EventRemoteDatasource>((ref) {
  return EventRemoteDatasourceImpl(Supabase.instance.client);
});

// Repository
final eventRepositoryProvider = Provider<EventRepository>((ref) {
  return EventRepositoryImpl(ref.watch(eventRemoteDatasourceProvider));
});

// Usecases
final getEventsUsecaseProvider = Provider<GetEvents>((ref) {
  return GetEvents(ref.watch(eventRepositoryProvider));
});

final getEventByIdUsecaseProvider = Provider<GetEventById>((ref) {
  return GetEventById(ref.watch(eventRepositoryProvider));
});

final createEventUsecaseProvider = Provider<CreateEvent>((ref) {
  return CreateEvent(ref.watch(eventRepositoryProvider));
});

final updateEventUsecaseProvider = Provider<UpdateEvent>((ref) {
  return UpdateEvent(ref.watch(eventRepositoryProvider));
});

final deleteEventUsecaseProvider = Provider<DeleteEvent>((ref) {
  return DeleteEvent(ref.watch(eventRepositoryProvider));
});

// Async state
final eventsProvider = FutureProvider.autoDispose
    .family<List<EventEntity>, String>((ref, vendorId) {
      return ref.watch(getEventsUsecaseProvider).call(vendorId);
    });

final eventDetailProvider = FutureProvider.autoDispose
    .family<EventEntity?, String>((ref, eventId) {
      return ref.watch(getEventByIdUsecaseProvider).call(eventId);
    });
