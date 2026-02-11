import 'package:app/features/clients/domain/entities/client_entity.dart';
import 'package:app/features/clients/domain/repositories/client_repository.dart';

class GetClients {
  final ClientRepository _repository;

  GetClients(this._repository);

  Future<List<ClientEntity>> call(String vendorId) {
    return _repository.getClients(vendorId);
  }
}
