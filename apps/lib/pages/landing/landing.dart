import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
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
  }

  reconnect() async {
    final connected = ref.read(connectDeviceProvider.notifier);
    final prefs = await SharedPreferences.getInstance();
    // try to find device from local storage
    final id = prefs.getString("id");
    if (id == null) {
      debugPrint("no remote id found");
      context.go("/scan");
      return;
    }
    debugPrint("try to connect to $id");
    final connectedDevices = await FlutterBluePlus.connectedSystemDevices;
    debugPrint("found ${connectedDevices.length} devices");
    final device = (connectedDevices)
        .firstWhereOrNull((element) => element.remoteId.toString() == id);
    if (device != null) {
      // initial connection of bluetooth
      await device.connect();
      await device.discoverServices();
      // redirect to home
      connected.set(device);
      // FlutterBluePlus.stopScan();
      debugPrint("connected to $id successfully");
      return true;
    } else {
      prefs.remove("id");
      debugPrint("%$id device not found");
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    reconnect();
    return const Scaffold();
  }
}
