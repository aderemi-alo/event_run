import 'package:app/features/clients/domain/entities/client_entity.dart';

abstract class ClientRepository {
  Future<List<ClientEntity>> getClients(String vendorId);
  Future<ClientEntity?> getClientById(String clientId);
  Future<ClientEntity> createClient({required ClientEntity client});
  Future<ClientEntity> updateClient({required ClientEntity client});
  Future<void> deleteClient(String clientId);
}
