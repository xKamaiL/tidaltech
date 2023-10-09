import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:niku/namespace.dart' as n;

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
    Permission.bluetooth.isGranted.then((isGranted) {
      if (!isGranted) {
        Permission.bluetooth.request().then((value) => {
              if (value.isGranted) {context.go("/landing")}
              //
            });
        return;
      }
      context.go("/landing");
    }).then((value) => FlutterNativeSplash.remove());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            n.Text('Please allow permission.')..bodyLarge,
            const SizedBox(height: 24),
            n.Button("Allow Permission".n)
              ..apply = XButtonStyle.confirm()
              ..px = 14
              ..onPressed = () async {
                final b = await Permission.bluetooth.request();
                if (b == PermissionStatus.permanentlyDenied) {
                  openAppSettings(); // open app setting
                }
              }
          ],
        ),
      ),
    );
  }
}
