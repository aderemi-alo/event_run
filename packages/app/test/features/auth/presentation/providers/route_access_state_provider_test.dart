import 'package:app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:app/features/vendor/domain/entities/vendor_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  VendorEntity buildVendor({required String ownerId}) {
    return VendorEntity(
      id: 'vendor-1',
      businessName: 'Acme Events',
      email: 'acme@example.com',
      phone: '08000000000',
      createdAt: DateTime(2026, 1, 1),
      ownerId: ownerId,
    );
  }

  ProviderContainer buildContainer({
    required AuthIdentity identity,
    required AsyncValue<VendorEntity?> vendorLookupValue,
  }) {
    return ProviderContainer(
      overrides: [
        authIdentityProvider.overrideWith((ref) => identity),
        vendorLookupProvider.overrideWith((ref, ownerId) => vendorLookupValue),
      ],
    );
  }

  group('routeAccessStateProvider', () {
    test('returns unauthenticated when there is no user', () {
      final container = buildContainer(
        identity: const AuthIdentity(userId: null),
        vendorLookupValue: const AsyncData(null),
      );
      addTearDown(container.dispose);

      final state = container.read(routeAccessStateProvider);

      expect(state.status, RouteAccessStatus.unauthenticated);
      expect(state.userId, isNull);
      expect(state.vendorId, isNull);
    });

    test('returns checkingVendor when vendor lookup is loading', () {
      final container = buildContainer(
        identity: const AuthIdentity(userId: 'user-1'),
        vendorLookupValue: const AsyncLoading(),
      );
      addTearDown(container.dispose);

      final state = container.read(routeAccessStateProvider);

      expect(state.status, RouteAccessStatus.checkingVendor);
      expect(state.userId, 'user-1');
      expect(state.vendorId, isNull);
    });

    test('returns authenticatedNoVendor when lookup returns null', () {
      final container = buildContainer(
        identity: const AuthIdentity(userId: 'user-1'),
        vendorLookupValue: const AsyncData(null),
      );
      addTearDown(container.dispose);

      final state = container.read(routeAccessStateProvider);

      expect(state.status, RouteAccessStatus.authenticatedNoVendor);
      expect(state.userId, 'user-1');
      expect(state.vendorId, isNull);
    });

    test('returns authenticatedWithVendor when vendor exists', () {
      final vendor = buildVendor(ownerId: 'user-1');
      final container = buildContainer(
        identity: const AuthIdentity(userId: 'user-1'),
        vendorLookupValue: AsyncData(vendor),
      );
      addTearDown(container.dispose);

      final state = container.read(routeAccessStateProvider);

      expect(state.status, RouteAccessStatus.authenticatedWithVendor);
      expect(state.userId, 'user-1');
      expect(state.vendorId, vendor.id);
    });

    test('returns vendorCheckError when lookup fails', () {
      final error = Exception('vendor lookup failed');
      final container = buildContainer(
        identity: const AuthIdentity(userId: 'user-1'),
        vendorLookupValue: AsyncError(error, StackTrace.empty),
      );
      addTearDown(container.dispose);

      final state = container.read(routeAccessStateProvider);

      expect(state.status, RouteAccessStatus.vendorCheckError);
      expect(state.userId, 'user-1');
      expect(state.error, error);
    });
  });
}
