import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/ui/panel.dart';

class ClockWidget extends HookConsumerWidget {
  const ClockWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snap) {
        return Panel(
            child: n.Column([
          n.Row([
            n.Icon(Icons.access_time_rounded)
              ..color = Colors.white.withOpacity(0.65)
              ..size = 14,
            n.Text("Current time")
              ..color = Colors.white.withOpacity(0.65)
              ..fontSize = 14
              ..textAlign = TextAlign.center
              ..bold
          ])
            ..mb = 4
            ..mainAxisAlignment = MainAxisAlignment.start
            ..crossAxisAlignment = CrossAxisAlignment.center
            ..gap = 4,
          n.Text(DateFormat('HH:mm').format(DateTime.now()))
            ..fontSize = 32
            ..textAlign = TextAlign.left
            ..bold
            ..color = Colors.white,
          n.Box()..h = 8,
          n.Text(DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()))
            ..color = Colors.white.withOpacity(0.75)
        ]));
      },
    );
  }
}
