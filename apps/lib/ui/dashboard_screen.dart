import 'dart:ui';

import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tidal_tech/models/devices.dart';
import 'package:tidal_tech/models/models.dart';
import 'package:tidal_tech/stores/bottom_bar.dart';
import 'package:tidal_tech/stores/device.dart';
import 'package:tidal_tech/ui/widget/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DashboardScreen extends HookConsumerWidget {
  static const blur = 5.0;

  final Widget child;

  const DashboardScreen(this.child, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(bottomBarProvider.select((value) => value));
    final isHome = position == 0;
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
          ? SafeArea(child: child)
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
                    child: child,
                  ),
                ),
              ),
            ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
