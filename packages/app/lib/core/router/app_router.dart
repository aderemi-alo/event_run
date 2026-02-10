import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:event_run/core/router/route_names.dart';
import 'package:event_run/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:event_run/features/auth/presentation/screens/login_screen.dart';
import 'package:event_run/features/auth/presentation/screens/signup_screen.dart';
import 'package:event_run/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:event_run/features/auth/presentation/screens/profile_screen.dart';
import 'package:event_run/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:event_run/features/vendor/presentation/screens/vendor_setup_screen.dart';
import 'package:event_run/features/vendor/presentation/screens/business_settings_screen.dart';
import 'package:event_run/features/vendor/presentation/screens/bank_details_screen.dart';
import 'package:event_run/features/vendor/presentation/screens/subscription_screen.dart';
import 'package:event_run/features/clients/presentation/screens/clients_list_screen.dart';
import 'package:event_run/features/clients/presentation/screens/client_detail_screen.dart';
import 'package:event_run/features/events/presentation/screens/events_list_screen.dart';
import 'package:event_run/features/events/presentation/screens/event_detail_screen.dart';
import 'package:event_run/features/events/presentation/screens/event_form_screen.dart';
import 'package:event_run/features/events/presentation/screens/event_requirements_screen.dart';
import 'package:event_run/features/inventory/presentation/screens/inventory_list_screen.dart';
import 'package:event_run/features/inventory/presentation/screens/inventory_form_screen.dart';
import 'package:event_run/features/invoices/presentation/screens/invoices_list_screen.dart';
import 'package:event_run/features/invoices/presentation/screens/invoice_detail_screen.dart';
import 'package:event_run/features/invoices/presentation/screens/invoice_form_screen.dart';
import 'package:event_run/features/invoices/presentation/screens/invoice_preview_screen.dart';
import 'package:event_run/features/invoices/presentation/screens/record_payment_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (BuildContext context, GoRouterState state) {
      // final isAuth = authState.isAuthenticated;
      // final onAuthPage =
      //     state.matchedLocation == '/login' ||
      //     state.matchedLocation == '/signup' ||
      //     state.matchedLocation == '/forgot-password';

      // if (!isAuth && !onAuthPage) return '/login';
      // if (isAuth && onAuthPage) return '/';
      // return null;
    },
    routes: [
      // Auth (public)
      GoRoute(
        path: '/login',
        name: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: RouteNames.signup,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: RouteNames.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      // Dashboard
      GoRoute(
        path: '/',
        name: RouteNames.dashboard,
        builder: (context, state) => const DashboardScreen(),
      ),

      // Profile
      GoRoute(
        path: '/profile',
        name: RouteNames.profile,
        builder: (context, state) => const ProfileScreen(),
      ),

      // Vendor
      GoRoute(
        path: '/vendor-setup',
        name: RouteNames.vendorSetup,
        builder: (context, state) => const VendorSetupScreen(),
      ),
      GoRoute(
        path: '/business-settings',
        name: RouteNames.businessSettings,
        builder: (context, state) => const BusinessSettingsScreen(),
      ),
      GoRoute(
        path: '/bank-details',
        name: RouteNames.bankDetails,
        builder: (context, state) => const BankDetailsScreen(),
      ),
      GoRoute(
        path: '/subscription',
        name: RouteNames.subscription,
        builder: (context, state) => const SubscriptionScreen(),
      ),

      // Clients
      GoRoute(
        path: '/clients',
        name: RouteNames.clients,

        builder: (context, state) {
          final vendorId = state.pathParameters['vendorId']!;
          return ClientsListScreen(vendorId: vendorId);
        },
      ),
      GoRoute(
        path: '/clients/:id',
        name: RouteNames.clientDetail,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ClientDetailScreen(clientId: id);
        },
      ),

      // Events
      GoRoute(
        path: '/events',
        name: RouteNames.events,
        builder: (context, state) {
          final vendorId = state.pathParameters['vendorId']!;
          return EventsListScreen(vendorId: vendorId);
        },
      ),
      GoRoute(
        path: '/events/new',
        name: RouteNames.eventForm,
        builder: (context, state) => const EventFormScreen(),
      ),
      GoRoute(
        path: '/events/:id',
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
        path: '/inventory',
        name: RouteNames.inventory,
        builder: (context, state) {
          final vendorId = state.pathParameters['vendorId']!;
          return InventoryListScreen(vendorId: vendorId);
        },
      ),
      GoRoute(
        path: '/inventory/new',
        name: RouteNames.inventoryForm,
        builder: (context, state) => const InventoryFormScreen(),
      ),
      GoRoute(
        path: '/inventory/:id/edit',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return InventoryFormScreen(itemId: id);
        },
      ),

      // Invoices
      GoRoute(
        path: '/invoices',
        name: RouteNames.invoices,
        builder: (context, state) {
          final vendorId = state.pathParameters['vendorId']!;
          return InvoicesListScreen(vendorId: vendorId);
        },
      ),
      GoRoute(
        path: '/invoices/new',
        name: RouteNames.invoiceForm,

        builder: (context, state) => const InvoiceFormScreen(vendorId: ''),
      ),
      GoRoute(
        path: '/invoices/:id',
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
              final vendorId = state.pathParameters['vendorId']!;
              return InvoiceFormScreen(invoiceId: id, vendorId: vendorId);
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
  );
});
