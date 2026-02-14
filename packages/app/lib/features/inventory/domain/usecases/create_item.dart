import 'package:app/core/utils/result.dart';
import 'package:app/features/inventory/domain/entities/create_inventory_item_params.dart';
import 'package:app/features/inventory/domain/entities/inventory_item_entity.dart';
import 'package:app/features/inventory/domain/repositories/inventory_repository.dart';

class CreateItem {
  final InventoryRepository _repository;

  CreateItem(this._repository);

  Future<Result<InventoryItemEntity>> call({
    required String vendorId,
    required CreateInventoryItemParams params,
  }) {
    return _repository.createItem(vendorId: vendorId, params: params);
  }
}
