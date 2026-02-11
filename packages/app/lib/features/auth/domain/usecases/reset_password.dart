import 'package:app/core/utils/result.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';

class ResetPassword {
  final AuthRepository _repository;

  ResetPassword(this._repository);

  Future<Result<void>> call({required String email}) {
    return _repository.resetPassword(email: email);
  }
}
