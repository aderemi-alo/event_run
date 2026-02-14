import 'package:app/core/router/app_shell.dart';
import 'package:app/features/inventory/presentation/screens/create_inventory_screen.dart';
import 'package:app/features/inventory/presentation/screens/inventory_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:app/core/router/route_names.dart';
import 'package:app/core/router/router_redirect.dart';
import 'package:app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:app/features/auth/presentation/screens/auth_gate_screen.dart';
import 'package:app/features/auth/presentation/screens/login_screen.dart';
import 'package:app/features/auth/presentation/screens/signup_screen.dart';
import 'package:app/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:app/features/auth/presentation/screens/profile_screen.dart';
import 'package:app/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:app/features/vendor/presentation/screens/vendor_setup_screen.dart';
import 'package:app/features/clients/presentation/screens/clients_list_screen.dart';
import 'package:app/features/clients/presentation/screens/client_detail_screen.dart';
import 'package:app/features/events/presentation/screens/events_list_screen.dart';
import 'package:app/features/events/presentation/screens/event_detail_screen.dart';
import 'package:app/features/events/presentation/screens/event_form_screen.dart';
import 'package:app/features/events/presentation/screens/event_requirements_screen.dart';
import 'package:app/features/inventory/presentation/screens/inventory_list_screen.dart';
import 'package:app/features/invoices/presentation/screens/invoices_list_screen.dart';
import 'package:app/features/invoices/presentation/screens/invoice_detail_screen.dart';
import 'package:app/features/invoices/presentation/screens/invoice_form_screen.dart';
import 'package:app/features/invoices/presentation/screens/invoice_preview_screen.dart';
import 'package:app/features/invoices/presentation/screens/record_payment_screen.dart';

final routerRefreshListenableProvider = Provider<Listenable>((ref) {
  final listenable = _RouterRefreshListenable(ref);
  ref.onDispose(listenable.dispose);
  return listenable;
});

final routerProvider = Provider<GoRouter>((ref) {
  final refreshListenable = ref.watch(routerRefreshListenableProvider);

  return GoRouter(
    initialLocation: RoutePaths.login,
    refreshListenable: refreshListenable,
    redirect: (BuildContext context, GoRouterState state) {
      final accessState = ref.read(routeAccessStateProvider);
      return resolveAppRedirect(
        accessState: accessState,
        location: state.matchedLocation,
      );
    },
    routes: [
      // ── Auth (no shell) ──
      GoRoute(
        path: RoutePaths.login,
        name: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RoutePaths.signup,
        name: RouteNames.signup,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: RoutePaths.forgotPassword,
        name: RouteNames.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: RoutePaths.authGate,
        name: RouteNames.authGate,
        builder: (context, state) => const AuthGateScreen(),
      ),
      GoRoute(
        path: RoutePaths.vendorSetup,
        name: RouteNames.vendorSetup,
        builder: (context, state) => const VendorSetupScreen(),
      ),

      // ── App shell (all authenticated screens) ──
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          // Dashboard
          GoRoute(
            path: RoutePaths.dashboard,
            name: RouteNames.dashboard,
            builder: (context, state) => const DashboardScreen(),
          ),

          // Profile
          GoRoute(
            path: RoutePaths.profile,
            name: RouteNames.profile,
            builder: (context, state) => const ProfileScreen(),
          ),

          // Clients
          GoRoute(
            path: RoutePaths.clients,
            name: RouteNames.clients,
            builder: (context, state) => const ClientsListScreen(),
          ),
          GoRoute(
            path: RoutePaths.clientDetail,
            name: RouteNames.clientDetail,
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return ClientDetailScreen(clientId: id);
            },
          ),

          // Events
          GoRoute(
            path: RoutePaths.events,
            name: RouteNames.events,
            builder: (context, state) => const EventsListScreen(),
          ),
          GoRoute(
            path: RoutePaths.eventForm,
            name: RouteNames.eventForm,
            builder: (context, state) => const EventFormScreen(),
          ),
          GoRoute(
            path: RoutePaths.eventDetail,
            name: RouteNames.eventDetail,
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return EventDetailScreen(eventId: id);
            },
            routes: [
              GoRoute(
                path: 'edit',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return EventFormScreen(eventId: id);
                },
              ),
              GoRoute(
                path: 'requirements',
                name: RouteNames.eventRequirements,
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return EventRequirementsScreen(eventId: id);
                },
              ),
            ],
          ),

          // Inventory
          GoRoute(
            path: RoutePaths.inventory,
            name: RouteNames.inventory,
            builder: (context, state) => const InventoryListScreen(),
          ),
          GoRoute(
            path: RoutePaths.createInventory,
            name: RouteNames.createInventory,
            builder: (context, state) => const CreateInventoryScreen(),
          ),
          GoRoute(
            path: RoutePaths.inventoryDetail,
            name: RouteNames.inventoryDetail,
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              final edit = state.uri.queryParameters['edit'] == 'true';
              return InventoryDetailScreen(itemId: id, startInEditMode: edit);
            },
          ),

          // Invoices
          GoRoute(
            path: RoutePaths.invoices,
            name: RouteNames.invoices,
            builder: (context, state) => const InvoicesListScreen(),
          ),
          GoRoute(
            path: RoutePaths.invoiceForm,
            name: RouteNames.invoiceForm,
            builder: (context, state) => const InvoiceFormScreen(),
          ),
          GoRoute(
            path: RoutePaths.invoiceDetail,
            name: RouteNames.invoiceDetail,
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return InvoiceDetailScreen(invoiceId: id);
            },
            routes: [
              GoRoute(
                path: 'edit',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return InvoiceFormScreen(invoiceId: id);
                },
              ),
              GoRoute(
                path: 'preview',
                name: RouteNames.invoicePreview,
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return InvoicePreviewScreen(invoiceId: id);
                },
              ),
              GoRoute(
                path: 'payment',
                name: RouteNames.recordPayment,
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return RecordPaymentScreen(invoiceId: id);
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

class _RouterRefreshListenable extends ChangeNotifier {
  _RouterRefreshListenable(this.ref) {
    _subscription = ref.listen<RouteAccessState>(
      routeAccessStateProvider,
      (_, __) => notifyListeners(),
    );
  }

  final Ref ref;
  late final ProviderSubscription<RouteAccessState> _subscription;

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}
