import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/models/devices.dart';
import 'package:tidal_tech/stores/device.dart';
import 'package:tidal_tech/ui/panel.dart';

class SunriseWidget extends HookConsumerWidget {
  const SunriseWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String sunriseTime = "-";
    String sunset = "-";
    final device = ref.watch(deviceProvider.select((value) => value.device));
    if (device != null) {
      final points = device.properties.schedule.points;
      if (points != null && points.firstOrNull != null) {
        sunriseTime = points.first.time;
        sunset = points.last.time;
      }
    }

    return Panel(
        child: AspectRatio(
      aspectRatio: 1,
      child: n.Column([
        n.Column([
          n.Row([
            n.Icon(Icons.sunny)
              ..color = Colors.yellow
              ..size = 14,
            n.Text("Sunrise")
              ..color = Colors.yellow
              ..overflow = TextOverflow.fade
              ..fontSize = 14
              ..textAlign = TextAlign.center
              ..bold
          ])
            ..mainAxisAlignment = MainAxisAlignment.start
            ..crossAxisAlignment = CrossAxisAlignment.center
            ..gap = 4,
          n.Text(sunriseTime)
            ..fontSize = 36
            ..textAlign = TextAlign.left
            ..wFull
            ..bold
            ..color = Colors.white.withOpacity(0.95),
        ]),
        n.Text("Sunset on $sunset")
          ..fontSize = 16
          ..textAlign = TextAlign.right
          ..bold
          ..wFull
          ..color = Colors.white.withOpacity(0.85)
      ])
        ..gap = 4
        ..spaceBetween
        ..crossAxisAlignment = CrossAxisAlignment.center,
    ));
  }
}
