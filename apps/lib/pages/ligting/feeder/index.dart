import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/pages/ligting/feeder/graph.dart';
import 'package:tidal_tech/pages/ligting/feeder/graph_control.dart';
import 'package:tidal_tech/pages/ligting/feeder/time_header.dart';
import 'package:tidal_tech/pages/ligting/spectrum_card.dart';
import 'package:tidal_tech/providers/ble_manager.dart';
import 'package:tidal_tech/providers/lighting.dart';
import 'package:tidal_tech/stores/device.dart';

class FeederControl extends ConsumerStatefulWidget {
  const FeederControl({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _FeederControlState();
  }
}

class _FeederControlState extends ConsumerState<ConsumerStatefulWidget> {
  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(timePointsNotifier, (_, value) {
      if (_timer?.isActive ?? false) _timer?.cancel();
      _timer = Timer(const Duration(milliseconds: 500), () {
        debugPrint("timePointsNotifier: $value");
        ref.read(bleManagerProvider.notifier).sendTimePoints(timePoints: value);
        ref.read(deviceProvider.notifier).updateSchedule(timePoints: value);
        //
      });
    });

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
