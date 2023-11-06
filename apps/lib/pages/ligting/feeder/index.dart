import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/pages/ligting/feeder/graph.dart';
import 'package:tidal_tech/pages/ligting/feeder/graph_control.dart';
import 'package:tidal_tech/pages/ligting/feeder/slider_dots.dart';
import 'package:tidal_tech/pages/ligting/feeder/time_header.dart';
import 'package:tidal_tech/pages/ligting/spectrum_card.dart';
import 'package:tidal_tech/providers/ble_manager.dart';
import 'package:tidal_tech/providers/lighting.dart';
import 'package:tidal_tech/stores/device.dart';

import '../../../theme/colors.dart';

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
      [
        n.Column([
          const TimeScheduleGraph(),
          const FeederTimeHeader(),
          n.Box(
            const SliderDots(),
          )
            ..bg = ThemeColors.zinc.shade100
            ..mt = 8,
        ])
          ..gap = 8,
        n.Column(const [
          SpectrumCard(),
          TimeScheduleControl(),
        ])
          ..gap = 8,
      ],
    )
      ..gap = 8
      ..my = 16
      ..mainAxisAlignment = MainAxisAlignment.spaceBetween
      ..hFull;
  }
}
