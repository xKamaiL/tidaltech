import 'dart:async';

import 'package:niku/namespace.dart' as n;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tidal_tech/providers/ble_manager.dart';
import 'package:tidal_tech/stores/static_led_mode.dart';

import '../../../providers/feeder.dart';
import '../../../theme/colors.dart';
import '../../../ui/widget/spectrum_bar.dart';

class StaticColorPalette extends StatefulHookConsumerWidget {
  const StaticColorPalette({super.key});

  @override
  ConsumerState<StaticColorPalette> createState() => _StaticColorPaletteState();
}

class _StaticColorPaletteState extends ConsumerState<StaticColorPalette> {
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors =
        ref.watch(staticLEDColorProvider.select((value) => value.colors));
    final whiteValue = colors[LED.white]!.intensity;
    final blueValue = colors[LED.blue]!.intensity;
    final royalBlueValue = colors[LED.royalBlue]!.intensity;
    final warmWhiteValue = colors[LED.warmWhite]!.intensity;
    final ultraVioletValue = colors[LED.ultraViolet]!.intensity;
    final redValue = colors[LED.red]!.intensity;
    final greenValue = colors[LED.green]!.intensity;

    ref.listen(staticLEDColorProvider, (_, next) {
      timer?.cancel();
      timer = Timer(const Duration(milliseconds: 500), () {
        ref.read(bleManagerProvider.notifier).setStaticColor(next.colors);
        //
      });
    });


    return Container(
      // rounded
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ThemeColors.zinc.shade100),
      child: n.Column([
        n.Row([
          Bar(LED.white, whiteValue, (dynamic value) {
            ref.read(staticLEDColorProvider.notifier).setWhite(value);
          }),
        ]),
        n.Column([
          n.Row([
            Bar(LED.blue, blueValue, (dynamic value) {
              ref.read(staticLEDColorProvider.notifier).setBlue(value);
            }),
            Bar(LED.royalBlue, royalBlueValue, (dynamic value) {
              ref.read(staticLEDColorProvider.notifier).setRoyalBlue(value);
            }),
          ]),
          n.Row([
            Bar(LED.warmWhite, warmWhiteValue, (dynamic value) {
              ref.read(staticLEDColorProvider.notifier).setWarmWhite(value);
            }),
            Bar(LED.ultraViolet, ultraVioletValue, (dynamic value) {
              ref.read(staticLEDColorProvider.notifier).setUltraViolet(value);
            }),
          ]),
          n.Row([
            Bar(LED.red, redValue, (dynamic value) {
              ref.read(staticLEDColorProvider.notifier).setRed(value);
            }),
            Bar(LED.green, greenValue, (dynamic value) {
              ref.read(staticLEDColorProvider.notifier).setGreen(value);
            }),
          ]),
        ]),
      ])
        ..wFull
        ..p = 8
        ..crossAxisAlignment = CrossAxisAlignment.start
        ..mainAxisAlignment = MainAxisAlignment.start
        ..gap = 4,
    );
  }
}
