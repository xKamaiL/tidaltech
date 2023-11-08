import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/providers/ble_manager.dart';
import 'package:tidal_tech/ui/panel.dart';

class ClockWidget extends ConsumerStatefulWidget {
  const ClockWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends ConsumerState<ClockWidget> {
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkRTC();
  }

  void checkRTC() {
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snap) {
        return Panel(
          onPressed: () {
            //
          },
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
            n.Text(DateFormat('d MMMM yyyy').format(DateTime.now()))
              ..color = Colors.white.withOpacity(0.75)
          ])
            ..gap = 4
            ..crossAxisAlignment = CrossAxisAlignment.center,
        );
      },
    );
  }
}
