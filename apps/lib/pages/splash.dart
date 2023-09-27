import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() async {
    super.initState();
    final isBleAllow = await Permission.bluetooth.isGranted;
    if (!isBleAllow) {
      final ok = await Permission.bluetooth.request();
      if (!ok.isGranted) {
        // TODO: show message that why you need this permission
        debugPrint("Permission.bluetooth.request() is not granted");
        return;
      }
    }
    Future.delayed(const Duration(microseconds: 100), () async {
      FlutterNativeSplash.remove();
      // check permission

      // check is that device already have connection
      context.go("/landing");
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Please allow permission'),
      ),
    );
  }
}
