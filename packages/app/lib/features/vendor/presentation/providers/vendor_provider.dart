import 'package:app/core/utils/result.dart';
import 'package:app/features/vendor/domain/entities/create_vendor_params.dart';
import 'package:app/features/vendor/domain/entities/update_vendor_params.dart';
import 'package:app/features/vendor/presentation/providers/vendor_providers_di.dart';
import 'package:app/features/vendor/presentation/providers/vendor_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VendorNotifier extends Notifier<VendorState> {
  @override
  VendorState build() => const VendorState();

  Future<void> getVendor(String id, String idType) async {
    state = state.copyWith(isLoading: true, error: null);
    final useCase = ref.read(getVendorUseCaseProvider);
    final result = await useCase.call(idType, id);
    if (!ref.mounted) return;
    result.fold(
      onSuccess: (vendor) {
        state = state.copyWith(currentVendor: vendor, isLoading: false);
      },
      onError: (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
    );
  }

  Future<void> createVendor(CreateVendorParams params) async {
    state = state.copyWith(actionState: ActionState.loading, actionError: null);
    final useCase = ref.read(createVendorUseCaseProvider);
    final result = await useCase.call(params: params);
    if (!ref.mounted) return;
    return result.fold(
      onSuccess: (vendor) {
        state = state.copyWith(
          currentVendor: vendor,
          actionState: ActionState.success,
        );
      },
      onError: (failure) {
        state = state.copyWith(
          actionState: ActionState.error,
          actionError: failure.message,
        );
      },
    );
  }

  Future<void> updateVendor(UpdateVendorParams params) async {
    state = state.copyWith(actionState: ActionState.loading, actionError: null);
    final useCase = ref.read(updateVendorUseCaseProvider);
    final result = await useCase.call(params: params);
    if (!ref.mounted) return;
    result.fold(
      onSuccess: (vendor) {
        state = state.copyWith(
          currentVendor: vendor,
          actionState: ActionState.success,
        );
      },
      onError: (failure) {
        state = state.copyWith(
          actionState: ActionState.error,
          actionError: failure.message,
        );
      },
    );
  }

  Future<void> deleteVendor(String vendorId) async {
    state = state.copyWith(actionState: ActionState.loading, actionError: null);
    final useCase = ref.read(deleteVendorUseCaseProvider);
    final result = await useCase.call(vendorId);
    if (!ref.mounted) return;
    result.fold(
      onSuccess: (_) {
        state = const VendorState(actionState: ActionState.success);
      },
      onError: (failure) {
        state = state.copyWith(
          actionState: ActionState.error,
          actionError: failure.message,
        );
      },
    );
  }

  void resetAction() {
    state = state.copyWith(actionState: ActionState.idle, actionError: null);
  }
}
