import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/pages/ligting/feeder/graph.dart';
import 'package:tidal_tech/pages/ligting/feeder/graph_control.dart';
import 'package:tidal_tech/pages/ligting/feeder/time_header.dart';
import 'package:tidal_tech/pages/ligting/spectrum_card.dart';

class FeederControl extends HookConsumerWidget {
  const FeederControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        FeederTimeHeader(),
        TimeScheduleGraph(),
        TimeScheduleControl(),
        SpectrumCard(),
      ],
    );
  }
}
