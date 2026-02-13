import 'package:app/core/router/route_names.dart';
import 'package:app/features/auth/presentation/providers/auth_state_provider.dart';

String? resolveAppRedirect({
  required RouteAccessState accessState,
  required String location,
}) {
  final isAuthRoute =
      location == RoutePaths.login ||
      location == RoutePaths.signup ||
      location == RoutePaths.forgotPassword;
  final isOnboardingRoute = location == RoutePaths.vendorSetup;
  final isGateRoute = location == RoutePaths.authGate;

  switch (accessState.status) {
    case RouteAccessStatus.unauthenticated:
      return isAuthRoute ? null : RoutePaths.login;
    case RouteAccessStatus.checkingVendor:
      return isGateRoute ? null : RoutePaths.authGate;
    case RouteAccessStatus.vendorCheckError:
      return isGateRoute ? null : RoutePaths.authGate;
    case RouteAccessStatus.authenticatedNoVendor:
      if (isOnboardingRoute) {
        return null;
      }
      return RoutePaths.vendorSetup;
    case RouteAccessStatus.authenticatedWithVendor:
      if (isAuthRoute || isOnboardingRoute || isGateRoute) {
        return RoutePaths.dashboard;
      }
      return null;
  }
}
