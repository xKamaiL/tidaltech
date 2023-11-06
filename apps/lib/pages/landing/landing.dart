import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../providers/ble_manager.dart';

import 'package:collection/collection.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({super.key});

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
    SharedPreferences.getInstance().then((prefs) {
      // try to find device from local storage
      final token = prefs.getString("token");
      final id = prefs.getString("id");
      if (id == null) {
        FlutterNativeSplash.remove();
        if (token == null) {
          context.go("/sign-in");
          return;
        }
        context.go("/scan");
        return;
      }
      ref.read(bleManagerProvider.notifier).setReconnectId(id);
      FlutterNativeSplash.remove();
      if (token == null) {
        context.go("/sign-in");
        return;
      }
      context.go("/home");
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
