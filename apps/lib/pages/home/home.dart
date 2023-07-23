import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:niku/namespace.dart' as n;
import 'package:responsive_grid/responsive_grid.dart';
import 'package:tidal_tech/pages/home/clock_widget.dart';
import 'package:tidal_tech/pages/home/history_widget.dart';
import 'package:tidal_tech/pages/home/moonlight_widget.dart';
import 'package:tidal_tech/pages/home/on_hour_widget.dart';
import 'package:tidal_tech/pages/home/sunrise_widget.dart';
import 'package:tidal_tech/pages/home/water_temp_widget.dart';
import 'package:tidal_tech/ui/info_title.dart';

class HomeIndexPage extends HookConsumerWidget {
  const HomeIndexPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: n.Text('Home'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          n.IconButton(
            Icons.add,
            onPressed: () {},
          ),
          n.IconButton(
            Icons.menu,
            onPressed: () {},
          ),
        ],
        centerTitle: false,
      ),
      backgroundColor: Colors.transparent,
      body: ResponsiveGridList(
        desiredItemWidth: 150,
        minSpacing: 8,
        children: [
          ClockWidget(),
          MoonLightWidget(),
          OnHourWidget(),
          WaterTemperature(),
          SunriseWidget(),
          HistoryWidget(),
        ],
      ),
    );
  }
}
