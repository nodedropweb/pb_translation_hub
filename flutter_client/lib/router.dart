import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/layout/app_layout.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'widgets/splash_screen.dart';
import 'widgets/page_transition.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/analytics/analytics_screen.dart';
import 'screens/editor/editor_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/categories/categories_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'screens/review/review_screen.dart';
import 'screens/review/review_list_screen.dart';
import 'screens/help/help_screen.dart';
import 'screens/help/crwb_study_screen.dart';
import 'screens/glossary/glossary_screen.dart';
import 'providers/auth_provider.dart';

// ── Auth-aware ChangeNotifier ──────────────────────────────────────────────
//
// GoRouter.refreshListenable expects a ChangeNotifier (or Listenable).
// This bridges Riverpod's authProvider to go_router's refresh mechanism so
// the redirect function is re-evaluated on every auth state change WITHOUT
// rebuilding the GoRouter instance itself.
//
// Rebuilding GoRouter on every change (the old `ref.watch` pattern) caused
// the router to reset to initialLocation:'/' whenever auth settled, which
// broke direct deep-link navigation (e.g. opening /edit/webform directly).

class _AuthRouterNotifier extends ChangeNotifier {
  _AuthRouterNotifier(Ref ref) {
    // Listen to auth state changes and notify go_router to re-check redirects
    ref.listen<AuthState>(authProvider, (_, __) => notifyListeners());
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = _AuthRouterNotifier(ref);

  return GoRouter(
    initialLocation: '/',
    // refreshListenable triggers redirect re-evaluation without recreating the router
    refreshListenable: notifier,
    redirect: (context, state) {
      // Read auth state without watching (avoids rebuilding the provider)
      final authState = ref.read(authProvider);

      if (authState.isLoading) return null; // wait for auth to settle

      final isAuth         = authState.user != null;
      final isLoggingIn    = state.uri.path == '/login';
      final isRegistering  = state.uri.path == '/register';

      if (!isAuth && !isLoggingIn && !isRegistering) return '/login';
      if (isAuth && (isLoggingIn || isRegistering)) return '/';

      // Translators may not access review routes
      if (isAuth && authState.user != null && !authState.user!.isReviewer) {
        final path = state.uri.path;
        if (path.startsWith('/review')) return '/';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          final authState = ref.watch(authProvider);
          if (authState.isLoading) {
            return const SplashScreen();
          }
          return AppLayout(child: PageTransition(child: child));
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/edit/:machineName',
            builder: (context, state) {
              final machineName = state.pathParameters['machineName']!;
              final filter = state.uri.queryParameters['filter'] ?? 'all';
              final search = state.uri.queryParameters['search'] ?? '';
              return EditorScreen(
                machineName: machineName,
                filter: filter,
                search: search,
              );
            },
          ),
          GoRoute(
            path: '/review/:machineName',
            builder: (context, state) {
              final machineName = state.pathParameters['machineName']!;
              final extra = state.extra as Map<String, dynamic>?;
              final inheritedQueue = (extra?['queue'] as List<dynamic>?)
                      ?.map((e) => e.toString())
                      .toList() ??
                  const [];
              return ReviewScreen(
                machineName: machineName,
                inheritedQueue: inheritedQueue,
              );
            },
          ),
          GoRoute(
            path: '/analytics',
            builder: (context, state) => const AnalyticsScreen(),
          ),
          GoRoute(
            path: '/categories',
            builder: (context, state) => const CategoriesScreen(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            path: '/review-list',
            builder: (context, state) => const ReviewListScreen(),
          ),
          GoRoute(
            path: '/help',
            builder: (context, state) => const HelpScreen(),
          ),
          GoRoute(
            path: '/help/crwb',
            builder: (context, state) => const CrwbStudyScreen(),
          ),
          GoRoute(
            path: '/glossary',
            builder: (context, state) => const GlossaryScreen(),
          ),
        ],
      ),
    ],
  );
});
