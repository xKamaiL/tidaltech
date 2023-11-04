import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/stores/stores.dart';
import 'package:tidal_tech/theme/colors.dart';

import '../stores/device.dart';
import '../styles/button.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    ref.read(userProvider.notifier).fetchMe();
    ref.read(deviceProvider.notifier).fetchCurrentDevice();
    [
      Permission.locationWhenInUse,
      Permission.locationAlways,
      Permission.bluetooth,
    ].request().then((value) {
      if ((value[Permission.locationAlways]!.isGranted ||
              value[Permission.locationWhenInUse]!.isGranted) &&
          value[Permission.bluetooth]!.isGranted) {
        context.go("/landing");
      }
    }).then((value) => FlutterNativeSplash.remove());

    // context.go("/landing");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 30, bottom: 30, left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 24),
                n.Column([
                  n.Icon(Icons.bluetooth, size: 128)
                    ..color = ThemeColors.primary,
                  n.Text("Permission Required")
                    ..mt = 24
                    ..fontWeight = FontWeight.w800
                    ..fontSize = 24
                    ..color = ThemeColors.foreground
                    ..center
                    ..mb = 8,
                ]),
                n.Text(
                    '${' ' * 10}We need some permission to connect to our devices bluetooth is for control and location services is for wifi smart config')
                  ..bodyLarge
                  ..mx = 24
                  ..softWrap,
                n.Button("Allow Permission".n)
                  ..fullWidth
                  ..apply = XButtonStyle.confirm()
                  ..px = 14
                  ..onPressed = () async {
                    [
                      Permission.locationWhenInUse,
                      Permission.locationAlways,
                      Permission.bluetooth,
                    ].request().then((value) {
                      if ((value[Permission.locationAlways]!.isGranted ||
                              value[Permission.locationWhenInUse]!.isGranted) &&
                          value[Permission.bluetooth]!.isGranted) {
                        context.go("/landing");
                      } else {
                        openAppSettings();
                      }
                    });
                  }
              ],
            ),
          ),
        ),
      ),
    );
  }
}
