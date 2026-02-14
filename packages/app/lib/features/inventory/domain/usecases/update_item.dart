import 'package:app/core/utils/result.dart';
import 'package:app/features/inventory/domain/entities/inventory_item_entity.dart';
import 'package:app/features/inventory/domain/entities/update_inventory_item_params.dart';
import 'package:app/features/inventory/domain/repositories/inventory_repository.dart';

class UpdateItem {
  final InventoryRepository _repository;

  UpdateItem(this._repository);

  Future<Result<InventoryItemEntity>> call({
    required UpdateInventoryItemParams params,
  }) {
    return _repository.updateItem(params: params);
  }
}
