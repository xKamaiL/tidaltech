import 'dart:ui';

import 'package:flutter/scheduler.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tidal_tech/models/devices.dart';
import 'package:tidal_tech/models/models.dart';
import 'package:tidal_tech/providers/ble_manager.dart';
import 'package:tidal_tech/stores/bottom_bar.dart';
import 'package:tidal_tech/stores/device.dart';
import 'package:tidal_tech/ui/widget/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const blur = 5.0;

class DashboardScreen extends StatefulHookConsumerWidget {
  final Widget child;

  const DashboardScreen({super.key, required this.child});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterBluePlus.adapterState.listen((event) {
      if (event == BluetoothAdapterState.on) {
        Future(() {
          ref.read(bleManagerProvider.notifier).reconnect();
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isHome =
        GoRouter.of(context).routerDelegate.currentConfiguration.fullPath ==
            '/home';
    //
    useEffect(() {
      ref.read(deviceProvider.notifier).fetchCurrentDevice();
      return null;
    });
    // add background image
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: !isHome
          ? SafeArea(child: widget.child)
          : Container(
              decoration: BoxDecoration(
                image: isHome
                    ? const DecorationImage(
                        image: ExactAssetImage("assets/hdlight.jpg"),
                        fit: BoxFit.fill,
                      )
                    : null,
              ),
              child: Container(
                // blur image
                decoration: const BoxDecoration(
                  color: Colors.transparent, // brightness
                ),

                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                  child: SafeArea(
                    child: widget.child,
                  ),
                ),
              ),
            ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
