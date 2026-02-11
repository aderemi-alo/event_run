import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/features/events/data/datasources/event_requirement_remote_datasource.dart';
import 'package:app/features/events/data/repositories/event_requirement_repository_impl.dart';
import 'package:app/features/events/domain/entities/event_requirement_entity.dart';
import 'package:app/features/events/domain/entities/inventory_conflict_entity.dart';
import 'package:app/features/events/domain/repositories/event_requirement_repository.dart';
import 'package:app/features/events/domain/usecases/get_event_requirements.dart';
import 'package:app/features/events/domain/usecases/add_event_requirement.dart';
import 'package:app/features/events/domain/usecases/check_inventory_conflicts.dart';

// Datasource
final eventRequirementRemoteDatasourceProvider =
    Provider<EventRequirementRemoteDatasource>((ref) {
      return EventRequirementRemoteDatasourceImpl(Supabase.instance.client);
    });

// Repository
final eventRequirementRepositoryProvider = Provider<EventRequirementRepository>(
  (ref) {
    return EventRequirementRepositoryImpl(
      ref.watch(eventRequirementRemoteDatasourceProvider),
    );
  },
);

// Usecases
final getEventRequirementsUsecaseProvider = Provider<GetEventRequirements>((
  ref,
) {
  return GetEventRequirements(ref.watch(eventRequirementRepositoryProvider));
});

final addEventRequirementUsecaseProvider = Provider<AddEventRequirement>((ref) {
  return AddEventRequirement(ref.watch(eventRequirementRepositoryProvider));
});

final checkInventoryConflictsUsecaseProvider =
    Provider<CheckInventoryConflicts>((ref) {
      return CheckInventoryConflicts(
        ref.watch(eventRequirementRepositoryProvider),
      );
    });

// Async state
final eventRequirementsProvider = FutureProvider.autoDispose
    .family<List<EventRequirementEntity>, String>((ref, eventId) {
      return ref.watch(getEventRequirementsUsecaseProvider).call(eventId);
    });

final inventoryConflictsProvider = FutureProvider.autoDispose
    .family<List<InventoryConflictEntity>, String>((ref, eventId) {
      return ref.watch(checkInventoryConflictsUsecaseProvider).call(eventId);
    });
