import 'package:event_run/features/clients/domain/entities/client_entity.dart';
import 'package:event_run/features/clients/domain/repositories/client_repository.dart';

class UpdateClient {
  final ClientRepository _repository;

  UpdateClient(this._repository);

  Future<ClientEntity> call({required ClientEntity client}) {
    return _repository.updateClient(client: client);
  }
}
