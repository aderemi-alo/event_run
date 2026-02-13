import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/core/utils/result.dart';
import 'package:app/features/vendor/domain/entities/vendor_entity.dart';
import 'package:app/features/vendor/presentation/providers/vendor_providers_di.dart';

final authStateProvider = StreamProvider<AuthState>((ref) {
  return Supabase.instance.client.auth.onAuthStateChange;
});

class AuthIdentity {
  const AuthIdentity({required this.userId});

  final String? userId;

  bool get isAuthenticated => userId != null;
}

enum RouteAccessStatus {
  unauthenticated,
  checkingVendor,
  authenticatedNoVendor,
  authenticatedWithVendor,
  vendorCheckError,
}

class RouteAccessState {
  const RouteAccessState._({
    required this.status,
    this.userId,
    this.vendor,
    this.error,
  });

  const RouteAccessState.unauthenticated()
    : this._(status: RouteAccessStatus.unauthenticated);

  const RouteAccessState.checkingVendor({required String userId})
    : this._(status: RouteAccessStatus.checkingVendor, userId: userId);

  const RouteAccessState.authenticatedNoVendor({required String userId})
    : this._(status: RouteAccessStatus.authenticatedNoVendor, userId: userId);

  const RouteAccessState.authenticatedWithVendor({
    required String userId,
    required VendorEntity vendor,
  }) : this._(
         status: RouteAccessStatus.authenticatedWithVendor,
         userId: userId,
         vendor: vendor,
       );

  const RouteAccessState.vendorCheckError({
    required String userId,
    required Object error,
  }) : this._(
         status: RouteAccessStatus.vendorCheckError,
         userId: userId,
         error: error,
       );

  final RouteAccessStatus status;
  final String? userId;
  final VendorEntity? vendor;
  final Object? error;

  String? get vendorId => vendor?.id;
}

final authIdentityProvider = Provider<AuthIdentity>((ref) {
  final authState = ref.watch(authStateProvider);
  final userFromStream = authState.value?.session?.user;
  final fallbackUser = Supabase.instance.client.auth.currentUser;
  final user = userFromStream ?? fallbackUser;

  return AuthIdentity(userId: user?.id);
});

final vendorLookupRequestProvider = FutureProvider.autoDispose
    .family<VendorEntity?, String>((ref, ownerId) async {
      final result = await ref
          .read(getVendorUseCaseProvider)
          .call('owner', ownerId);

      return result.fold(
        onSuccess: (vendor) => vendor,
        onError: (failure) => throw Exception(failure.message),
      );
    });

final routeAccessStateProvider = Provider<RouteAccessState>((ref) {
  final identity = ref.watch(authIdentityProvider);

  if (!identity.isAuthenticated || identity.userId == null) {
    return const RouteAccessState.unauthenticated();
  }

  final vendorState = ref.watch(vendorLookupRequestProvider(identity.userId!));

  return vendorState.when(
    data: (vendor) {
      if (vendor == null) {
        return RouteAccessState.authenticatedNoVendor(userId: identity.userId!);
      }

      return RouteAccessState.authenticatedWithVendor(
        userId: identity.userId!,
        vendor: vendor,
      );
    },
    loading: () => RouteAccessState.checkingVendor(userId: identity.userId!),
    error: (error, _) => RouteAccessState.vendorCheckError(
      userId: identity.userId!,
      error: error,
    ),
  );
});

final currentVendorIdProvider = Provider<String?>((ref) {
  return ref.watch(routeAccessStateProvider).vendorId;
});

final currentUserProvider = Provider<User?>((ref) {
  return Supabase.instance.client.auth.currentUser;
});
