import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/ui/panel.dart';

class MoonLightWidget extends HookConsumerWidget {
  const MoonLightWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snap) {
        return Panel(
            child: n.Column([
          n.Row([
            n.Icon(Icons.notification_important_outlined)
              ..color = Colors.white.withOpacity(0.65)
              ..size = 14,
            n.Text("Notification")
              ..color = Colors.white.withOpacity(0.65)
              ..fontSize = 14
              ..textAlign = TextAlign.center
              ..bold
          ])
            ..mainAxisAlignment = MainAxisAlignment.start
            ..crossAxisAlignment = CrossAxisAlignment.center
            ..gap = 4,
          n.Box()..h = 30,
          n.Text("No notification")..color = Colors.white.withOpacity(0.75),
          n.Box()..h = 30,
        ]));
      },
    );
  }
}
