import 'package:event_run/features/clients/domain/entities/client_entity.dart';
import 'package:event_run/features/clients/domain/repositories/client_repository.dart';

class GetClientById {
  final ClientRepository _repository;

  GetClientById(this._repository);

  Future<ClientEntity?> call(String clientId) {
    return _repository.getClientById(clientId);
  }
}
