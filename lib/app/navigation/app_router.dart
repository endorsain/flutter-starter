import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/application/auth_controller.dart';
import '../../features/auth/presentation/login_page.dart';
import '../../features/auth/presentation/register_page.dart';
import '../../features/camera/presentation/camera_page.dart';
import '../../features/home/presentation/home_shell.dart';
import '../../features/map/presentation/map_page.dart';
import '../../features/playground/presentation/playground_page.dart';
import '../../features/settings/presentation/settings_page.dart';
import '../../features/users/presentation/profile_page.dart';
import 'app_routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final refreshListenable = _RouterRefreshListenable();
  ref.listen(authControllerProvider, (previous, next) {
    refreshListenable.refresh();
  });

  final router = GoRouter(
    initialLocation: AppRoutes.loginPath,
    refreshListenable: refreshListenable,
    redirect: (context, state) {
      final isAuthenticated =
          ref.read(authControllerProvider).asData?.value ?? false;
      final isAuthenticationRoute =
          state.matchedLocation == AppRoutes.loginPath ||
          state.matchedLocation == AppRoutes.registerPath;

      if (!isAuthenticated && !isAuthenticationRoute) {
        return AppRoutes.loginPath;
      }

      if (isAuthenticated && isAuthenticationRoute) {
        return AppRoutes.mapPath;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.loginPath,
        name: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.registerPath,
        name: AppRoutes.register,
        builder: (context, state) => const RegisterPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomeShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.mapPath,
                name: AppRoutes.map,
                builder: (context, state) => const MapPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profilePath,
                name: AppRoutes.profile,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settingsPath,
                name: AppRoutes.settings,
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.cameraPath,
                name: AppRoutes.camera,
                builder: (context, state) => const CameraPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.playgroundPath,
                name: AppRoutes.playground,
                builder: (context, state) => const PlaygroundPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  ref.onDispose(router.dispose);
  ref.onDispose(refreshListenable.dispose);
  return router;
});

class _RouterRefreshListenable extends ChangeNotifier {
  void refresh() => notifyListeners();
}
