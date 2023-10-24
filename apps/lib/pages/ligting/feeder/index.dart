import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/pages/ligting/feeder/graph.dart';
import 'package:tidal_tech/pages/ligting/feeder/graph_control.dart';
import 'package:tidal_tech/pages/ligting/feeder/time_header.dart';
import 'package:tidal_tech/pages/ligting/spectrum_card.dart';
import 'package:tidal_tech/providers/ble_manager.dart';
import 'package:tidal_tech/providers/feeder.dart';
import 'package:tidal_tech/providers/lighting.dart';

class FeederControl extends ConsumerStatefulWidget {
  const FeederControl({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _FeederControlState();
  }
}

class _FeederControlState extends ConsumerState<ConsumerStatefulWidget> {
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      final timePoints = ref.read(timePointsNotifier);
      ref
          .read(bleManagerProvider.notifier)
          .sendTimePoints(timePoints: timePoints);
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final manager = ref.read(bleManagerProvider.notifier);

    return n.Column(
      const [
        FeederTimeHeader(),
        TimeScheduleGraph(),
        TimeScheduleControl(),
        SpectrumCard(),
      ],
    )..gap = 8;
  }
}
