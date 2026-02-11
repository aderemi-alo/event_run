import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/core/constants/supabase_constants.dart';
import 'package:app/core/error/exceptions.dart';
import 'package:app/features/clients/data/models/client_model.dart';

abstract class ClientRemoteDatasource {
  Future<List<ClientModel>> getClients(String vendorId);
  Future<ClientModel?> getClientById(String clientId);
  Future<ClientModel> createClient({required ClientModel client});
  Future<ClientModel> updateClient({required ClientModel client});
  Future<void> deleteClient(String clientId);
}

class ClientRemoteDatasourceImpl implements ClientRemoteDatasource {
  final SupabaseClient _client;

  ClientRemoteDatasourceImpl(this._client);

  @override
  Future<List<ClientModel>> getClients(String vendorId) async {
    try {
      final response = await _client
          .from(SupabaseConstants.clientsTable)
          .select()
          .eq('vendor_id', vendorId)
          .order('full_name');

      return response.map((json) => ClientModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<ClientModel?> getClientById(String clientId) async {
    try {
      final response = await _client
          .from(SupabaseConstants.clientsTable)
          .select()
          .eq('id', clientId)
          .maybeSingle();

      if (response == null) return null;
      return ClientModel.fromJson(response);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<ClientModel> createClient({required ClientModel client}) async {
    try {
      final response = await _client
          .from(SupabaseConstants.clientsTable)
          .insert(client.toJson())
          .select()
          .single();

      return ClientModel.fromJson(response);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<ClientModel> updateClient({required ClientModel client}) async {
    try {
      final response = await _client
          .from(SupabaseConstants.clientsTable)
          .update(client.toJson())
          .eq('id', client.id)
          .select()
          .single();

      return ClientModel.fromJson(response);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> deleteClient(String clientId) async {
    try {
      await _client
          .from(SupabaseConstants.clientsTable)
          .delete()
          .eq('id', clientId);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
