import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_run/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:event_run/features/auth/presentation/ui/views/onboarding_view.dart';
import 'package:event_run/features/auth/presentation/ui/views/login_view.dart';
import 'package:event_run/features/auth/presentation/ui/views/signup_view.dart';

/// Router configuration provider
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isAuthenticated = authState.isAuthenticated;
      final hasCompletedOnboarding = authState.hasCompletedOnboarding;
      final isOnboarding = state.matchedLocation == '/onboarding';
      final isLogin = state.matchedLocation == '/login';
      final isSignup = state.matchedLocation == '/signup';

      // If not authenticated
      if (!isAuthenticated) {
        // If onboarding not complete and not on onboarding page
        if (!hasCompletedOnboarding && !isOnboarding) {
          return '/onboarding';
        }

        // If onboarding complete and trying to access protected route
        if (hasCompletedOnboarding && !isLogin && !isSignup && !isOnboarding) {
          return '/login';
        }
      }

      // If authenticated and trying to access auth pages, redirect to dashboard
      if (isAuthenticated && (isOnboarding || isLogin || isSignup)) {
        return '/';
      }

      // No redirect needed
      return null;
    },
    routes: [
      // Public/Auth routes
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginView()),
      GoRoute(path: '/signup', builder: (context, state) => const SignupView()),

      // Protected routes - Dashboard (temporary placeholder)
      GoRoute(
        path: '/',
        builder: (context, state) => const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.dashboard, size: 64),
                SizedBox(height: 16),
                Text(
                  'Dashboard',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('Coming soon...'),
              ],
            ),
          ),
        ),
      ),
    ],
  );
});
