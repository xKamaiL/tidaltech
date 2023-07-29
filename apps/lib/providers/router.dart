import 'package:tidal_tech/pages/ligting/feeder/profile/index.dart';
import 'package:tidal_tech/pages/ligting/lighting.dart';
import 'package:tidal_tech/pages/scenes/scenes.dart';
import 'package:tidal_tech/pages/settings/settings.dart';
import 'package:tidal_tech/stores/bottom_bar.dart';
import 'package:tidal_tech/stores/stores.dart';
import 'package:tidal_tech/ui/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tidal_tech/ui/onboard_screen.dart';

import '../pages/home/home.dart';
import '../pages/login.dart';
import '../pages/splash.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);
  return GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: router,
    redirect: router._redirectLogic,
    routes: router._routes,
    initialLocation: "/",
  );
});

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen(userProvider, (_, __) => notifyListeners());
    _ref.listen(bottomBarProvider, (_, __) => notifyListeners());
  }

  List<RouteBase> get _routes => [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) =>
              const MaterialPage(child: SplashPage()),
        ),
        ShellRoute(
          routes: [
            GoRoute(
              name: "sign-in",
              path: '/sign-in',
              pageBuilder: (context, state) => MaterialPage(child: LoginPage()),
            ),
          ],
          builder: (context, state, child) => OnBoardScreen(child: child),
        ),
        ShellRoute(
          builder: (context, state, child) => DashboardScreen(
            child,
          ),
          routes: [
            GoRoute(
              name: "home",
              path: '/home',
              pageBuilder: (_, state) => NoTransitionPage(
                key: state.pageKey,
                restorationId: state.pageKey.value,
                child: HomeIndexPage(),
              ),
            ),
            GoRoute(
              name: "lighting",
              path: "/lighting",
              pageBuilder: (_, state) => NoTransitionPage(
                key: state.pageKey,
                restorationId: state.pageKey.value,
                child: const LightingIndexPage(),
              ),
            ),
            GoRoute(
              name: "lighting-feeder-profile",
              path: "/lighting/feeder/profile",
              pageBuilder: (_, state) => MaterialPage(
                key: state.pageKey,
                restorationId: state.pageKey.value,
                child: const LightingFeederProfilePage(),
              ),
            ),
            GoRoute(
                name: "scenes",
                path: "/scenes",
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    key: state.pageKey,
                    restorationId: state.pageKey.value,
                    child: ScenesIndexPage(),
                  );
                }),
            GoRoute(
                name: "setting",
                path: "/setting",
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    key: state.pageKey,
                    restorationId: state.pageKey.value,
                    child: SettingsIndexPage(),
                  );
                }),
          ],
        )
      ];

  String? _redirectLogic(BuildContext buildContext, GoRouterState state) {
    if (state.path == null) {
      return null;
    }
    if (state.path == "/") {
      return null;
    }
    final user = _ref.read(userProvider);
    final areWeOnSignInPage = state.path == '/sign-in';

    if (user == null && !areWeOnSignInPage) {
      return '/sign-in';
    } else if (user != null && areWeOnSignInPage) {
      return '/';
    }

    return null;
  }
}
