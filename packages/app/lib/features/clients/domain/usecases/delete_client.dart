import 'package:app/features/clients/domain/repositories/client_repository.dart';

class DeleteClient {
  final ClientRepository _repository;

  DeleteClient(this._repository);

  Future<void> call(String clientId) {
    return _repository.deleteClient(clientId);
  }
}
