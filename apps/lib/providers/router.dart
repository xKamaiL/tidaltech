import 'package:TidalTech/pages/ligting/lighting.dart';
import 'package:TidalTech/stores/stores.dart';
import 'package:TidalTech/ui/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
  }

  List<RouteBase> get _routes => [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) =>
              const MaterialPage(child: SplashPage()),
        ),
        GoRoute(
          path: '/sign-in',
          pageBuilder: (context, state) => MaterialPage(child: LoginPage()),
        ),
        ShellRoute(
          builder: (context, state, child) => DashboardScreen(
            child: child,
            backgroundImage: "bg.jpeg",
          ),
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) =>
                  MaterialPage(child: HomeIndexPage()),
            ),
            GoRoute(
                path: "/lighting",
                pageBuilder: (context, state) {
                  return MaterialPage(child: LightingIndexPage());
                }),
            GoRoute(
                path: "/scenes",
                pageBuilder: (context, state) {
                  return MaterialPage(child: Container());
                }),
            GoRoute(
                path: "/setting",
                pageBuilder: (context, state) {
                  return MaterialPage(child: Container());
                }),
          ],
        )
      ];

  String? _redirectLogic(BuildContext buildContext, GoRouterState state) {
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
