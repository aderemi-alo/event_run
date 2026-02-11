import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/core/constants/supabase_constants.dart';
import 'package:app/core/error/exceptions.dart';
import 'package:app/features/events/data/models/event_requirement_model.dart';
import 'package:app/features/events/data/models/inventory_conflict_model.dart';

abstract class EventRequirementRemoteDatasource {
  Future<List<EventRequirementModel>> getRequirements(String eventId);
  Future<EventRequirementModel> addRequirement({
    required EventRequirementModel requirement,
  });
  Future<EventRequirementModel> updateRequirement({
    required EventRequirementModel requirement,
  });
  Future<void> removeRequirement(String requirementId);
  Future<List<InventoryConflictModel>> checkConflicts(String eventId);
}

class EventRequirementRemoteDatasourceImpl
    implements EventRequirementRemoteDatasource {
  final SupabaseClient _client;

  EventRequirementRemoteDatasourceImpl(this._client);

  @override
  Future<List<EventRequirementModel>> getRequirements(String eventId) async {
    try {
      final response = await _client
          .from(SupabaseConstants.eventRequirementsTable)
          .select()
          .eq('event_id', eventId);

      return response
          .map((json) => EventRequirementModel.fromJson(json))
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<EventRequirementModel> addRequirement({
    required EventRequirementModel requirement,
  }) async {
    try {
      final response = await _client
          .from(SupabaseConstants.eventRequirementsTable)
          .insert(requirement.toJson())
          .select()
          .single();

      return EventRequirementModel.fromJson(response);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<EventRequirementModel> updateRequirement({
    required EventRequirementModel requirement,
  }) async {
    try {
      final response = await _client
          .from(SupabaseConstants.eventRequirementsTable)
          .update(requirement.toJson())
          .eq('id', requirement.id)
          .select()
          .single();

      return EventRequirementModel.fromJson(response);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> removeRequirement(String requirementId) async {
    try {
      await _client
          .from(SupabaseConstants.eventRequirementsTable)
          .delete()
          .eq('id', requirementId);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<InventoryConflictModel>> checkConflicts(String eventId) async {
    try {
      final response = await _client.rpc(
        'check_inventory_conflicts',
        params: {'p_event_id': eventId},
      );

      return (response as List)
          .map(
            (json) =>
                InventoryConflictModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
