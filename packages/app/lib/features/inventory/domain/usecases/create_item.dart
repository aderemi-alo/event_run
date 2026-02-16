import 'package:app/core/uscase/base_usecase.dart';
import 'package:app/core/utils/result.dart';
import 'package:app/features/inventory/domain/entities/create_inventory_item_params.dart';
import 'package:app/features/inventory/domain/entities/inventory_item_entity.dart';
import 'package:app/features/inventory/domain/repositories/inventory_repository.dart';

class CreateItem
    implements UseCase<InventoryItemEntity, CreateInventoryItemParams> {
  final InventoryRepository _repository;

  CreateItem(this._repository);

  @override
  Future<Result<InventoryItemEntity>> call({
    required CreateInventoryItemParams params,
  }) {
    return _repository.createItem(params: params);
  }
}
