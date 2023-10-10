import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tidal_tech/providers/devices.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../providers/ble_manager.dart';

import 'package:collection/collection.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      FlutterBluePlus.turnOn();
    }
    ref.read(bleManagerProvider.notifier).init();
    SharedPreferences.getInstance().then((prefs) {
      context.go("/scan");
      return;
      // try to find device from local storage
      final id = prefs.getString("id");
      if (id == null) {
        FlutterNativeSplash.remove();
        context.go("/scan");
        return;
      }
      FlutterNativeSplash.remove();
      context.go("/home");
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
