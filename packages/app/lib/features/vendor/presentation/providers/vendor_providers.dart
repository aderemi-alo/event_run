import 'package:app/features/vendor/domain/entities/vendor_entity.dart';
import 'package:app/core/utils/result.dart';
import 'package:app/features/vendor/presentation/providers/vendor_providers_di.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@Deprecated(
  'Use vendor_provider.dart for state management and vendor_providers_di.dart for DI.',
)
final getVendorUsecaseProvider = getVendorUseCaseProvider;

@Deprecated(
  'Use vendor_provider.dart for state management and vendor_providers_di.dart for DI.',
)
final createVendorUsecaseProvider = createVendorUseCaseProvider;

@Deprecated(
  'Use vendor_provider.dart for state management and vendor_providers_di.dart for DI.',
)
final updateVendorUsecaseProvider = updateVendorUseCaseProvider;

@Deprecated(
  'Use vendor_provider.dart for state management and vendor_providers_di.dart for DI.',
)
final updateBankDetailsUsecaseProvider = updateBankDetailsUseCaseProvider;

@Deprecated(
  'Use vendor_provider.dart for state management and vendor_providers_di.dart for DI.',
)
final vendorProvider = FutureProvider.autoDispose.family<VendorEntity?, String>(
  (ref, ownerId) async {
    final result = await ref
        .read(getVendorUseCaseProvider)
        .call('owner', ownerId);
    return result.fold(
      onSuccess: (vendor) => vendor,
      onError: (failure) => throw Exception(failure.message),
    );
  },
);
