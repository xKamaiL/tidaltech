import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:niku/namespace.dart' as n;
import 'package:responsive_grid/responsive_grid.dart';
import 'package:tidal_tech/models/models.dart';
import 'package:tidal_tech/pages/home/clock_widget.dart';
import 'package:tidal_tech/pages/home/history_widget.dart';
import 'package:tidal_tech/pages/home/moonlight_widget.dart';
import 'package:tidal_tech/pages/home/on_hour_widget.dart';
import 'package:tidal_tech/pages/home/sunrise_widget.dart';
import 'package:tidal_tech/pages/home/water_temp_widget.dart';
import 'package:tidal_tech/providers/ble_manager.dart';
import 'package:tidal_tech/providers/feeder.dart';
import 'package:tidal_tech/stores/device.dart';
import 'package:tidal_tech/stores/lighting.dart';
import 'package:tidal_tech/stores/static_led_mode.dart';
import 'package:tidal_tech/ui/BluetoothStatusIcon.dart';
import 'package:tidal_tech/ui/widget/scene_card.dart';

class HomeIndexPage extends HookConsumerWidget {
  const HomeIndexPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    void runScene(String id) async {
      final res = await api.getScene(GetSceneParam(id: id));
      if (!res.ok) {
        debugPrint(res.error!.message);
        return;
      }
      final result = res.result;
      if (result == null) {
        debugPrint("result is null");
        return;
      }
      if (result.colors.isEmpty) {
        debugPrint("result.colors is empty");
        return;
      }
      ref.read(deviceProvider.notifier).setMode(LightingMode.ambient);
      ref.read(bleManagerProvider.notifier).setStaticColor(
            result.colors.first.color
                .map((key, value) => MapEntry(key, ColorPoint(key, value))),
          );
      ref.read(staticLEDColorProvider.notifier).setFromScene(result);
    }

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
        rowMainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ClockWidget(),
          const MoonLightWidget(),
          const OnHourWidget(),
          const WaterTemperature(),
          const SunriseWidget(),
          const HistoryWidget(),
          n.Text("Scenes")
            ..mt = 8
            ..color = Colors.white
            ..bold
            ..fontSize = 24,
          n.Box(),
          SceneCard(
            scene: Scene(
              title: "Full Spectrum",
              icon: CupertinoIcons.color_filter,
            ),
            onTap: () async {
              runScene("full");
            },
          ),
          SceneCard(
            scene: Scene(
              title: "Sunrise",
              icon: CupertinoIcons.sunrise,
            ),
            onTap: () {
              //
              runScene("sunrise");
            },
          ),
          SceneCard(
            scene: Scene(
              title: "Moonlight",
              icon: CupertinoIcons.moon,
            ),
            onTap: () {
              runScene("moonlight");
            },
          ),
          n.Box(),
        ],
      ),
    );
  }
}
