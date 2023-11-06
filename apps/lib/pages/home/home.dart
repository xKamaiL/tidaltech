import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:niku/namespace.dart' as n;
import 'package:responsive_grid/responsive_grid.dart';
import 'package:tidal_tech/pages/home/clock_widget.dart';
import 'package:tidal_tech/pages/home/history_widget.dart';
import 'package:tidal_tech/pages/home/moonlight_widget.dart';
import 'package:tidal_tech/pages/home/on_hour_widget.dart';
import 'package:tidal_tech/pages/home/sunrise_widget.dart';
import 'package:tidal_tech/pages/home/water_temp_widget.dart';
import 'package:tidal_tech/ui/BluetoothStatusIcon.dart';
import 'package:tidal_tech/ui/widget/scene_card.dart';

class HomeIndexPage extends HookConsumerWidget {
  const HomeIndexPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //

    return Scaffold(
      appBar: AppBar(
        title: n.Text('Your Home')
          ..bold
          ..fontSize = 18.0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: const [
          BluetoothStatusIcon(
            isDark: false,
          ),
        ],
        centerTitle: false,
      ),
      backgroundColor: Colors.transparent,
      body: ResponsiveGridList(
        desiredItemWidth: 150,
        minSpacing: 8,
        children: [
          const ClockWidget(),
          const MoonLightWidget(),
          const OnHourWidget(),
          const WaterTemperature(),
          const SunriseWidget(),
          const HistoryWidget(),
          n.Text("Scenes")
            ..color = Colors.white
            ..bold
            ..fontSize = 24,
          n.Box(),
          SceneCard(
              scene: Scene(
                title: "Morning",
                icon: Icons.wb_sunny_outlined,
              ),
              onTap: () {
                //
              }),
          SceneCard(
            scene: Scene(
              title: "Thunderstorm",
              icon: Icons.thunderstorm_outlined,
            ),
            onTap: () async {
              //
            },
            active: true,
          ),
        ],
      ),
    );
  }
}
