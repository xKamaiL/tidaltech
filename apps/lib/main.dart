import 'package:TidalTech/pages/landing.dart';
import 'package:TidalTech/pages/login.dart';
import 'package:TidalTech/stores/stores.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vrouter/vrouter.dart';

void main() {
  runApp(
    const ProviderScope(
      overrides: [],
      child: MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userProvider);
    final isLoggedIn = user.;
    return SafeArea(
      child: VRouter(
        title: "Tidal Tech",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        beforeEnter: (vRedirector) async => {
          // run every time before enter
          // print("Init App")
        },
        mode: VRouterMode.history,
        routes: [
          VWidget(path: "/login", widget: LoginPage(), stackedRoutes: [
            VGuard(
                beforeEnter: (vRedirector) async {
                  print(user);
                  if (!isLoggedIn) {
                    vRedirector.to("/login");
                    return;
                  }
                  return;
                },
                stackedRoutes: [
                  VWidget(path: "/home", widget: const LandingPage()),
                  VWidget(path: "/devices", widget: const LandingPage()),
                  VWidget(path: "/profile", widget: const LandingPage()),
                ])
          ]),

          // :_ is a path parameters named _
          // .+ is a regexp to match any path
          VRouteRedirector(path: ':_(.+)', redirectTo: '/home')
        ],
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
