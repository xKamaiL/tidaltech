import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/models/models.dart';
import 'package:tidal_tech/providers/feeder.dart';
import 'package:tidal_tech/stores/device.dart';
import 'package:tidal_tech/ui/panel.dart';

class OnHourWidget extends HookConsumerWidget {
  const OnHourWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(deviceProvider.select((value) => value.device));
    int white = 0;
    int blue = 0;
    int red = 0;
    int warmWhite = 0;
    int green = 0;
    int royalBlue = 0;
    int ultraViolet = 0;
    if (d != null) {
      if (d.properties.mode == "schedule") {
        final points = d.properties.schedule.points;
        if (points != null) {
          //
          final now = DateTime.now();
          final hour = now.hour;
          final minute = now.minute;
          // find schedule which in range of now

          final greater = points.where((element) {
            final h = int.parse(element.time.split(":")[0]);
            final m = int.parse(element.time.split(":")[1]);
            if (h <= hour) {
              if (h == hour && m > minute) {
                return false;
              }
              return true;
            }
            return false;
          });
          final greatest = greater.reduce((curr, next) {
            final h = int.parse(curr.time.split(":")[0]);
            final m = int.parse(curr.time.split(":")[1]);
            final nh = int.parse(next.time.split(":")[0]);
            final nm = int.parse(next.time.split(":")[1]);
            if (h > nh) {
              return curr;
            } else if (h == nh) {
              if (m > nm) {
                return curr;
              }
            }
            return next;
          });
          final colors = greatest.brightness;
          white = colors["white"] ?? 0;
          blue = colors["blue"] ?? 0;
          red = colors["red"] ?? 0;
          warmWhite = colors["warmWhite"] ?? 0;
          green = colors["green"] ?? 0;
          royalBlue = colors["royalBlue"] ?? 0;
          ultraViolet = colors["ultraViolet"] ?? 0;
        }
      } else {
        final colors = d.properties.colors;
        if (colors != null) {
          white = colors["white"] ?? 0;
          blue = colors["blue"] ?? 0;
          red = colors["red"] ?? 0;
          warmWhite = colors["warmWhite"] ?? 0;
          green = colors["green"] ?? 0;
          royalBlue = colors["royalBlue"] ?? 0;
          ultraViolet = colors["ultraViolet"] ?? 0;
        }
      }
    }

    return Panel(
        child: AspectRatio(
      aspectRatio: 1,
      child: n.Column([
        n.Row([
          n.Icon(Icons.light_mode_rounded)
            ..color = Colors.limeAccent
            ..size = 14,
          n.Text("Level")
            // aquarium colors
            ..color = Colors.limeAccent
            ..fontSize = 14
            ..textAlign = TextAlign.center
            ..bold
        ])
          ..mainAxisAlignment = MainAxisAlignment.start
          ..crossAxisAlignment = CrossAxisAlignment.center
          ..gap = 4,
        Expanded(
          child: n.Row([
            BarColor(
              ledColor[LED.white]!,
              white,
            ),
            BarColor(
              ledColor[LED.blue]!,
              blue,
            ),
            BarColor(
              ledColor[LED.red]!,
              red,
            ),
            //
            BarColor(
              ledColor[LED.warmWhite]!,
              warmWhite,
            ),
            BarColor(
              ledColor[LED.green]!,
              green,
            ),
            BarColor(
              ledColor[LED.royalBlue]!,
              royalBlue,
            ),
            //
            BarColor(
              ledColor[LED.ultraViolet]!,
              ultraViolet,
            ),
          ])
            ..spaceBetween
            ..gap = 4
            ..pb = 8
            ..hFull,
        ),
      ])
        ..gap = 4
        ..spaceBetween,
    ));
  }
}

class BarColor extends HookConsumerWidget {
  final Color color;
  final int level;

  const BarColor(this.color, this.level, {super.key});

  final maxHeight = 140.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: maxHeight,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 15,
              height: maxHeight * (level.toDouble() / 100),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: color,
              ),
            ),
          ),
          Container(
            // Add the line below
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.symmetric(
                vertical: BorderSide(
                  color: color.withOpacity(0.5),
                  width: 8.0,
                ),
                horizontal: BorderSide(
                  color: color.withOpacity(0.5),
                  width: 8.0,
                ),
              ),
            ),
            child: Container(),
          )
        ],
      ),
    );
  }
}
