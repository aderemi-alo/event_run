import 'package:event_run/features/clients/domain/entities/client_entity.dart';
import 'package:event_run/features/clients/domain/repositories/client_repository.dart';

class CreateClient {
  final ClientRepository _repository;

  CreateClient(this._repository);

  Future<ClientEntity> call({required ClientEntity client}) {
    return _repository.createClient(client: client);
  }
}
