import 'package:permission_handler/permission_handler.dart';
import 'package:tidal_tech/pages/landing/landing.dart';
import 'package:tidal_tech/pages/ligting/feeder/profile/index.dart';
import 'package:tidal_tech/pages/ligting/lighting.dart';
import 'package:tidal_tech/pages/scenes/scenes.dart';
import 'package:tidal_tech/pages/settings/bluetooth/bluetooth.dart';
import 'package:tidal_tech/pages/settings/settings.dart';
import 'package:tidal_tech/pages/sign_up.dart';
import 'package:tidal_tech/stores/bottom_bar.dart';
import 'package:tidal_tech/stores/stores.dart';
import 'package:tidal_tech/ui/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tidal_tech/ui/onboard_screen.dart';

import '../pages/home/home.dart';
import '../pages/login.dart';
import '../pages/scan/scan.dart';
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
            GoRoute(
              path: "/sign-up",
              pageBuilder: (context, state) =>
                  MaterialPage(child: SignUpPage()),
            )
          ],
          builder: (context, state, child) => OnBoardScreen(child: child),
        ),
        ShellRoute(
            builder: (context, state, child) => OnBoardScreen(child: child),
            routes: [
              GoRoute(
                path: "/landing",
                pageBuilder: (_, __) =>
                    const MaterialPage(child: LandingPage()),
              ),
              GoRoute(
                path: "/scan",
                pageBuilder: (_, __) => const MaterialPage(child: ScanPage()),
              ),
            ]),
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
                child: const HomeIndexPage(),
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
                    child: const ScenesIndexPage(),
                  );
                }),
            GoRoute(
              name: "setting",
              path: "/setting",
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  key: state.pageKey,
                  restorationId: state.pageKey.value,
                  child: const SettingsIndexPage(),
                );
              },
              routes: [
                GoRoute(
                  name: "settings-bluetooth",
                  path: "bluetooth",
                  pageBuilder: (_, state) => MaterialPage(
                    key: state.pageKey,
                    restorationId: state.pageKey.value,
                    child: const BluetoothSettingPage(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ];

  Future<String?> _redirectLogic(
      BuildContext buildContext, GoRouterState state) async {
    final nextPath = state.fullPath;
    if (nextPath == null) {
      return null;
    }
    if (nextPath == "/") {
      return null;
    }

    debugPrint("current path is $nextPath");
    final user = _ref.read(userProvider);

    final onSignInPage = nextPath == '/sign-in' || nextPath == '/sign-up';

    if (user == null && !onSignInPage) {
      return '/sign-in';
    } else if (user != null && onSignInPage) {
      return '/';
    }

    return null;
  }
}

final routeInformationProvider =
    ChangeNotifierProvider<GoRouteInformationProvider>((ref) {
  final router = ref.watch(routerProvider);
  return router.routeInformationProvider;
});

final currentRouteProvider = Provider((ref) {
  return ref.watch(routeInformationProvider).value.uri;
});
