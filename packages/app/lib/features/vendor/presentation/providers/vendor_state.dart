import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app/features/vendor/domain/entities/vendor_entity.dart';

part 'vendor_state.freezed.dart';

@freezed
class VendorState with _$VendorState {
  const factory VendorState({
    @Default(null) VendorEntity? currentVendor,
    @Default(false) bool isLoading,
    @Default(null) String? error,
    @Default(ActionState.idle) ActionState actionState,
    @Default(null) String? actionError,
  }) = _VendorState;
}

enum ActionState { idle, loading, success, error }
