import 'package:app/features/inventory/domain/repositories/inventory_repository.dart';

class DeleteItem {
  final InventoryRepository _repository;

  DeleteItem(this._repository);

  Future<void> call(String itemId) {
    return _repository.deleteItem(itemId);
  }
}
