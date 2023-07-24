import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/ui/panel.dart';

class WaterTemperature extends HookConsumerWidget {
  const WaterTemperature({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snap) {
        return Panel(
            child: AspectRatio(
          aspectRatio: 1,
          child: n.Column([
            n.Row([
              n.Icon(Icons.water)
                ..color = Colors.blue
                ..size = 14,
              n.Text("Water Quality")
                ..color = Colors.blue
                ..overflow = TextOverflow.fade
                ..fontSize = 14
                ..textAlign = TextAlign.center
                ..bold
            ])
              ..mainAxisAlignment = MainAxisAlignment.start
              ..crossAxisAlignment = CrossAxisAlignment.center
              ..gap = 4,
            n.Column([
              Info(label: "Temp", value: "26.5 °C"),
              Info(label: "Quality", value: "pH 8.1"),
              Info(label: "Salinity", value: "1.025"),
            ])
              ..gap = 4,
            n.Box(),
          ])
            ..gap = 4
            ..spaceBetween
            ..crossAxisAlignment = CrossAxisAlignment.center,
        ));
      },
    );
  }
}

class Info extends StatelessWidget {
  final String label;
  final String value;

  const Info({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return n.Row([
      n.Text(label)
        ..fontSize = 18
        ..textAlign = TextAlign.left
        ..bold
        ..color = Colors.white.withOpacity(0.85),
      n.Text(value)
        ..fontSize = 18
        ..textAlign = TextAlign.right
        ..bold
        ..color = Colors.white.withOpacity(0.95)
    ])
      ..spaceBetween;
  }
}
