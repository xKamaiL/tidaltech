import 'dart:ui';

import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tidal_tech/stores/bottom_bar.dart';
import 'package:tidal_tech/ui/widget/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DashboardScreen extends HookConsumerWidget {
  final Widget child;
  static const blur = 5.0;

  const DashboardScreen(this.child, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(bottomBarProvider.select((value) => value));
    final isHome = position == 0;

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
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0), // brightness
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
