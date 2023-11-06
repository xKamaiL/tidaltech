import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tidal_tech/pages/ligting/feeder/line_chart.dart';
import 'package:tidal_tech/pages/ligting/feeder/slider_dots.dart';
import 'package:tidal_tech/providers/feeder.dart';
import 'package:tidal_tech/providers/lighting.dart';
import 'package:tidal_tech/theme/colors.dart';
import 'package:niku/namespace.dart' as n;

class TimeScheduleGraph extends HookConsumerWidget {
  const TimeScheduleGraph({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        AspectRatio(
          aspectRatio: 2,
          child: ShowLineChart(),
        ),
      ],
    );
  }
}
