import 'package:app/features/clients/data/datasources/client_remote_datasource.dart';
import 'package:app/features/clients/data/models/client_model.dart';
import 'package:app/features/clients/domain/entities/client_entity.dart';
import 'package:app/features/clients/domain/repositories/client_repository.dart';

class ClientRepositoryImpl implements ClientRepository {
  final ClientRemoteDatasource _datasource;

  ClientRepositoryImpl(this._datasource);

  @override
  Future<List<ClientEntity>> getClients(String vendorId) {
    return _datasource.getClients(vendorId);
  }

  @override
  Future<ClientEntity?> getClientById(String clientId) {
    return _datasource.getClientById(clientId);
  }

  @override
  Future<ClientEntity> createClient({required ClientEntity client}) {
    final model = ClientModel(
      id: client.id,
      vendorId: client.vendorId,
      fullName: client.fullName,
      email: client.email,
      phone: client.phone,
      notes: client.notes,
      createdAt: client.createdAt,
    );
    return _datasource.createClient(client: model);
  }

  @override
  Future<ClientEntity> updateClient({required ClientEntity client}) {
    final model = ClientModel(
      id: client.id,
      vendorId: client.vendorId,
      fullName: client.fullName,
      email: client.email,
      phone: client.phone,
      notes: client.notes,
      createdAt: client.createdAt,
    );
    return _datasource.updateClient(client: model);
  }

  @override
  Future<void> deleteClient(String clientId) {
    return _datasource.deleteClient(clientId);
  }
}
