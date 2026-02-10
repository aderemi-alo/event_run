import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:event_run/features/clients/data/datasources/client_remote_datasource.dart';
import 'package:event_run/features/clients/data/repositories/client_repository_impl.dart';
import 'package:event_run/features/clients/domain/entities/client_entity.dart';
import 'package:event_run/features/clients/domain/repositories/client_repository.dart';
import 'package:event_run/features/clients/domain/usecases/get_clients.dart';
import 'package:event_run/features/clients/domain/usecases/get_client_by_id.dart';
import 'package:event_run/features/clients/domain/usecases/create_client.dart';
import 'package:event_run/features/clients/domain/usecases/update_client.dart';
import 'package:event_run/features/clients/domain/usecases/delete_client.dart';

// Datasource
final clientRemoteDatasourceProvider =
    Provider<ClientRemoteDatasource>((ref) {
  return ClientRemoteDatasourceImpl(Supabase.instance.client);
});

// Repository
final clientRepositoryProvider = Provider<ClientRepository>((ref) {
  return ClientRepositoryImpl(ref.watch(clientRemoteDatasourceProvider));
});

// Usecases
final getClientsUsecaseProvider = Provider<GetClients>((ref) {
  return GetClients(ref.watch(clientRepositoryProvider));
});

final getClientByIdUsecaseProvider = Provider<GetClientById>((ref) {
  return GetClientById(ref.watch(clientRepositoryProvider));
});

final createClientUsecaseProvider = Provider<CreateClient>((ref) {
  return CreateClient(ref.watch(clientRepositoryProvider));
});

final updateClientUsecaseProvider = Provider<UpdateClient>((ref) {
  return UpdateClient(ref.watch(clientRepositoryProvider));
});

final deleteClientUsecaseProvider = Provider<DeleteClient>((ref) {
  return DeleteClient(ref.watch(clientRepositoryProvider));
});

// Async state
final clientsProvider = FutureProvider.autoDispose
    .family<List<ClientEntity>, String>((ref, vendorId) {
  return ref.watch(getClientsUsecaseProvider).call(vendorId);
});

final clientDetailProvider = FutureProvider.autoDispose
    .family<ClientEntity?, String>((ref, clientId) {
  return ref.watch(getClientByIdUsecaseProvider).call(clientId);
});
