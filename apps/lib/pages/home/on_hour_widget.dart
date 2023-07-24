import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/ui/panel.dart';

class OnHourWidget extends HookConsumerWidget {
  const OnHourWidget({super.key});

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
              n.Icon(Icons.timer_outlined)
                ..color = Color(0xFF00BFA5)
                ..size = 14,
              n.Text("Turn On")
                // aquarium colors
                ..color = Color(0xFF00BFA5)
                ..fontSize = 14
                ..textAlign = TextAlign.center
                ..bold
            ])
              ..mainAxisAlignment = MainAxisAlignment.start
              ..crossAxisAlignment = CrossAxisAlignment.center
              ..gap = 4,
            n.Column([
              n.Text("6 Hours")
                ..fontSize = 28
                ..textAlign = TextAlign.left
                ..bold
                ..color = Colors.white,
              n.Text("24 Minutes")
                ..fontSize = 22
                ..textAlign = TextAlign.left
                ..bold
                ..color = Colors.white.withOpacity(0.95),
            ]),
            n.Text("continuously")
              ..fontSize = 14
              ..textAlign = TextAlign.center
              ..bold
              ..color = Colors.white.withOpacity(0.65)
          ])
            ..gap = 4
            ..spaceBetween,
        ));
      },
    );
  }
}
