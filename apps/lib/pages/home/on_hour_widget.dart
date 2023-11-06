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
    final d = ref.read(deviceProvider).device;

    return Panel(
        child: AspectRatio(
      aspectRatio: 1,
      child: n.Column([
        n.Row([
          n.Icon(Icons.timer_outlined)
            ..color = const Color(0xFF00BFA5)
            ..size = 14,
          n.Text("Schedule")
            // aquarium colors
            ..color = const Color(0xFF00BFA5)
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
              1,
            ),
            BarColor(
              ledColor[LED.blue]!,
              50,
            ),
            BarColor(
              ledColor[LED.red]!,
              20,
            ),
            //
            BarColor(
              ledColor[LED.warmWhite]!,
              30,
            ),
            BarColor(
              ledColor[LED.green]!,
              40,
            ),
            BarColor(
              ledColor[LED.royalBlue]!,
              50,
            ),
            //
            BarColor(
              ledColor[LED.ultraViolet]!,
              60,
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
