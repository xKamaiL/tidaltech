import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/providers/feeder.dart';
import 'package:tidal_tech/providers/lighting.dart';
import 'package:tidal_tech/theme/colors.dart';

import '../../ui/widget/spectrum_bar.dart';

class SpectrumCard extends HookConsumerWidget {
  const SpectrumCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tp = ref.watch(timePointEditingProvider);
    final tps = ref.watch(timePointsNotifier);

    if (tp == null) {
      return n.Column([
        n.Icon(Icons.info_outline)
          ..color = ThemeColors.zinc.shade400
          ..size = 48,
        n.Box(
          n.Text(
            tps.isEmpty ? "Schedule is empty" : "Select a time point to edit",
          )
            ..color = ThemeColors.mutedForeground
            ..center,
        )..px = 24,
      ])
        ..wFull
        ..gap = 8
        ..height = 200
        ..mainAxisAlignment = MainAxisAlignment.center;
    }
    // access to timePoint real values

    final whiteValue = tp.colors[LED.white]!.intensity;
    final blueValue = tp.colors[LED.blue]!.intensity;
    final royalBlueValue = tp.colors[LED.royalBlue]!.intensity;
    final warmWhiteValue = tp.colors[LED.warmWhite]!.intensity;
    final ultraVioletValue = tp.colors[LED.ultraViolet]!.intensity;
    final redValue = tp.colors[LED.red]!.intensity;
    final greenValue = tp.colors[LED.green]!.intensity;

    return Container(
      // rounded
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ThemeColors.zinc.shade100),
      child: n.Column([
        n.Row([
          Bar(LED.white, whiteValue, (dynamic value) {
            ref.read(timePointEditingProvider.notifier).updateWhite(value);
          }),
        ]),
        n.Column([
          n.Row([
            Bar(LED.blue, blueValue, (dynamic value) {
              ref.read(timePointEditingProvider.notifier).updateBlue(value);
            }),
            Bar(LED.royalBlue, royalBlueValue, (dynamic value) {
              ref
                  .read(timePointEditingProvider.notifier)
                  .updateRoyalBlue(value);
            }),
          ]),
          n.Row([
            Bar(LED.warmWhite, warmWhiteValue, (dynamic value) {
              ref
                  .read(timePointEditingProvider.notifier)
                  .updateWarmWhite(value);
            }),
            Bar(LED.ultraViolet, ultraVioletValue, (dynamic value) {
              ref
                  .read(timePointEditingProvider.notifier)
                  .updateUltraViolet(value);
            }),
          ]),
          n.Row([
            Bar(LED.red, redValue, (dynamic value) {
              ref.read(timePointEditingProvider.notifier).updateRed(value);
            }),
            Bar(LED.green, greenValue, (dynamic value) {
              ref.read(timePointEditingProvider.notifier).updateGreen(value);
            }),
          ]),
          n.Row([
            n.Button(
              n.Icon(Icons.arrow_left)..color = ThemeColors.foreground,
            )
              ..onPressed = () {
                ref.read(timePointsNotifier.notifier).editPrevious();
              }
              ..color = ThemeColors.foreground
              ..rounded = 8
              ..p = 0
              ..m = 0
              ..splash = ThemeColors.mutedForeground.withOpacity(0.1)
              ..bg = ThemeColors.white,
            n.Row(
              [
                CupertinoButton(
                  onPressed: () {
                    //
                    showCupertinoModalPopup(
                        context: context,
                        builder: (builder) {
                          return Container(
                            height: 300,
                            padding: const EdgeInsets.only(top: 0),
                            margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            color: CupertinoColors.systemBackground
                                .resolveFrom(context),
                            child: SafeArea(
                              top: false,
                              child: CupertinoDatePicker(
                                initialDateTime:
                                    DateTime(0, 0, 0, tp.hour, tp.minute),
                                mode: CupertinoDatePickerMode.time,
                                use24hFormat: true,
                                minuteInterval: 5,
                                maximumDate: DateTime(0, 0, 0, 23, 50),
                                minimumDate: DateTime(0, 0, 0, 0, 10),
                                // This is called when the user changes the time.
                                onDateTimeChanged: (DateTime newTime) {
                                  ref.read(timePointsNotifier.notifier).update(
                                      tp.id,
                                      tp.copyWith(
                                        hour: newTime.hour,
                                        minute: newTime.minute,
                                      ));
                                  ref
                                      .read(timePointEditingProvider.notifier)
                                      .set(tp.copyWith(
                                        hour: newTime.hour,
                                        minute: newTime.minute,
                                      ));
                                },
                              ),
                            ),
                          );
                        });
                  },
                  padding: const EdgeInsets.all(0),
                  child: n.Text(tp.toString())
                    ..fontSize = 24
                    ..m = 0,
                ),
              ],
            )
              ..alignBottomCenter
              ..mainAxisAlignment = MainAxisAlignment.center,
            n.Button(
              n.Icon(Icons.arrow_right_outlined)
                ..color = ThemeColors.foreground,
            )
              ..onPressed = () {
                ref.read(timePointsNotifier.notifier).editNext();
              }
              ..color = ThemeColors.foreground
              ..rounded = 8
              ..p = 0
              ..m = 0
              ..splash = ThemeColors.mutedForeground.withOpacity(0.1)
              ..bg = ThemeColors.white,
          ])
            ..crossAxisAlignment = CrossAxisAlignment.center
            ..spaceBetween,
        ])
      ])
        ..wFull
        ..p = 8
        ..crossAxisAlignment = CrossAxisAlignment.start
        ..mainAxisAlignment = MainAxisAlignment.start
        ..gap = 4,
    );
  }
}

