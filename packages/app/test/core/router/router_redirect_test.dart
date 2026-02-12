import 'package:app/core/router/route_names.dart';
import 'package:app/core/router/router_redirect.dart';
import 'package:app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:app/features/vendor/domain/entities/vendor_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  VendorEntity buildVendor() {
    return VendorEntity(
      id: 'vendor-1',
      businessName: 'Acme Events',
      email: 'acme@example.com',
      phone: '08000000000',
      createdAt: DateTime(2026, 1, 1),
      ownerId: 'user-1',
    );
  }

  group('resolveAppRedirect', () {
    test('redirects unauthenticated user from protected route to login', () {
      final redirect = resolveAppRedirect(
        accessState: const RouteAccessState.unauthenticated(),
        location: RoutePaths.dashboard,
      );

      expect(redirect, RoutePaths.login);
    });

    test('allows unauthenticated user on auth routes', () {
      final redirect = resolveAppRedirect(
        accessState: const RouteAccessState.unauthenticated(),
        location: RoutePaths.signup,
      );

      expect(redirect, isNull);
    });

    test('redirects checkingVendor state to auth gate', () {
      final redirect = resolveAppRedirect(
        accessState: const RouteAccessState.checkingVendor(userId: 'user-1'),
        location: RoutePaths.events,
      );

      expect(redirect, RoutePaths.authGate);
    });

    test('keeps checkingVendor state on auth gate', () {
      final redirect = resolveAppRedirect(
        accessState: const RouteAccessState.checkingVendor(userId: 'user-1'),
        location: RoutePaths.authGate,
      );

      expect(redirect, isNull);
    });

    test('redirects vendor lookup error to auth gate', () {
      final redirect = resolveAppRedirect(
        accessState: RouteAccessState.vendorCheckError(
          userId: 'user-1',
          error: Exception('lookup failed'),
        ),
        location: RoutePaths.dashboard,
      );

      expect(redirect, RoutePaths.authGate);
    });

    test('redirects authenticated user without vendor to vendor setup', () {
      final redirect = resolveAppRedirect(
        accessState: const RouteAccessState.authenticatedNoVendor(
          userId: 'user-1',
        ),
        location: RoutePaths.invoices,
      );

      expect(redirect, RoutePaths.vendorSetup);
    });

    test('allows authenticated user without vendor on vendor setup route', () {
      final redirect = resolveAppRedirect(
        accessState: const RouteAccessState.authenticatedNoVendor(
          userId: 'user-1',
        ),
        location: RoutePaths.vendorSetup,
      );

      expect(redirect, isNull);
    });

    test('moves authenticated user without vendor from gate to vendor setup', () {
      final redirect = resolveAppRedirect(
        accessState: const RouteAccessState.authenticatedNoVendor(
          userId: 'user-1',
        ),
        location: RoutePaths.authGate,
      );

      expect(redirect, RoutePaths.vendorSetup);
    });

    test('redirects authenticated user with vendor away from auth routes', () {
      final redirect = resolveAppRedirect(
        accessState: RouteAccessState.authenticatedWithVendor(
          userId: 'user-1',
          vendor: buildVendor(),
        ),
        location: RoutePaths.login,
      );

      expect(redirect, RoutePaths.dashboard);
    });

    test('allows authenticated user with vendor on protected routes', () {
      final redirect = resolveAppRedirect(
        accessState: RouteAccessState.authenticatedWithVendor(
          userId: 'user-1',
          vendor: buildVendor(),
        ),
        location: RoutePaths.events,
      );

      expect(redirect, isNull);
    });
  });
}
