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
            n.Box()..h = 8,
            n.Row([
              n.Text("Temp")
                ..fontSize = 18
                ..textAlign = TextAlign.left
                ..bold
                ..color = Colors.white.withOpacity(0.85),
              n.Text("26.5 °C")
                ..fontSize = 18
                ..textAlign = TextAlign.right
                ..bold
                ..color = Colors.white.withOpacity(0.95)
            ])
              ..mainAxisAlignment = MainAxisAlignment.spaceBetween,
            n.Box()..h = 8,
            n.Row([
              n.Text("Quality")
                ..fontSize = 18
                ..textAlign = TextAlign.left
                ..bold
                ..color = Colors.white.withOpacity(0.85),
              n.Text("pH 8.1")
                ..fontSize = 18
                ..textAlign = TextAlign.right
                ..bold
                ..color = Colors.white.withOpacity(0.95)
            ])
              ..mainAxisAlignment = MainAxisAlignment.spaceBetween,
            n.Box()..h = 8,
            n.Row([
              n.Text("Salinity")
                ..fontSize = 18
                ..textAlign = TextAlign.left
                ..bold
                ..color = Colors.white.withOpacity(0.85),
              n.Text("1.025")
                ..fontSize = 18
                ..textAlign = TextAlign.right
                ..bold
                ..color = Colors.white.withOpacity(0.95)
            ])
              ..mainAxisAlignment = MainAxisAlignment.spaceBetween,
            n.Box()..h = 8,
          ]),
        ));
      },
    );
  }
}
