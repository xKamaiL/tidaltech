import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tidal_tech/stores/bottom_bar.dart';
import 'package:tidal_tech/theme/colors.dart';

class BottomNavigationWidget extends ConsumerStatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  ConsumerState<BottomNavigationWidget> createState() =>
      _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState
    extends ConsumerState<BottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    final position = ref.watch(bottomBarProvider.select((value) => value));

    final isHomePage =
        GoRouter.of(context).routerDelegate.currentConfiguration.fullPath ==
            '/home';

    return CupertinoTabBar(
      currentIndex: position,
      backgroundColor: Colors.transparent,
      activeColor: isHomePage ? Colors.white : ThemeColors.primary,
      inactiveColor: isHomePage
          ? Colors.white.withOpacity(0.7)
          : ThemeColors.mutedForeground,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.light_mode),
          label: 'Lighting',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.movie_creation),
          label: 'Scenes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Setting',
        ),
      ],
      onTap: onTabTapped,
    );
  }

  void onTabTapped(int index) {
    ref.read(bottomBarProvider.notifier).setPosition(index);
    switch (index) {
      case 0:
        context.go("/home");
        break;
      case 1:
        context.go("/lighting");
        break;
      case 2:
        context.go("/scenes");
        break;
      case 3:
        context.go("/setting");
        break;
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(10.0);
}
