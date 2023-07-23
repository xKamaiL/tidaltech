import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/ui/panel.dart';

class SunriseWidget extends HookConsumerWidget {
  const SunriseWidget({super.key});

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
            n.Text("06:00")
              ..fontSize = 36
              ..textAlign = TextAlign.left
              ..wFull
              ..bold
              ..color = Colors.white.withOpacity(0.95),
            n.Icon(Icons.looks_outlined)
              ..color = Colors.white.withOpacity(0.45)
              ..size = 50,
            n.Box()..h = 8,
            n.Text("Sunset on 18:56")
              ..fontSize = 16
              ..textAlign = TextAlign.right
              ..bold
              ..wFull
              ..color = Colors.white.withOpacity(0.85)
          ])
            ..mainAxisAlignment = MainAxisAlignment.start,
        ));
      },
    );
  }
}
