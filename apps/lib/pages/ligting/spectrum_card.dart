import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:tidal_tech/providers/feeder.dart';
import 'package:tidal_tech/providers/lighting.dart';
import 'package:tidal_tech/theme/colors.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class SpectrumCard extends HookConsumerWidget {
  const SpectrumCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tp = ref.watch(timePointEditingProvider);
    if (tp == null) {
      return n.Box(
        n.Text("Please select time point above")
          ..color = ThemeColors.mutedForeground
          ..mt = 16,
      )..p = 16;
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
          n.Text("Time: ${tp.toString()}")
            ..fontSize = 18
            ..bold,
          n.Text("Same colors")
            ..fontSize = 16
            ..color = ThemeColors.foreground
        ])
          ..crossAxisAlignment = CrossAxisAlignment.center
          ..spaceBetween
          ..px = 16,
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
        ])
      ])
        ..wFull
        ..py = 16
        ..crossAxisAlignment = CrossAxisAlignment.start
        ..mainAxisAlignment = MainAxisAlignment.start
        ..gap = 4,
    );
  }
}

class Bar extends HookConsumerWidget {
  final LED color;
  final int value;
  final ValueChanged<dynamic>? onChange;

  const Bar(this.color, this.value, this.onChange, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // random value
    return Expanded(
      child: SfSliderTheme(
        data: SfSliderThemeData(),
        child: SfSlider(
          min: 0.0,
          max: 100.0,
          value: value,
          enableTooltip: true,
          minorTicksPerInterval: 1,
          activeColor: ledColor[color],
          inactiveColor: ledColor[color]!.withOpacity(0.3),
          stepSize: 1,
          tooltipShape: SfRectangularTooltipShape(),
          tooltipTextFormatterCallback:
              (dynamic actualValue, String formattedText) {
            return '$formattedText%';
          },
          onChanged: (dynamic value) {
            onChange!(value);
          },
        ),
      ),
    );
  }
}

class RoundedRectangleSeekbarShape extends SliderComponentShape {
  //The radius of the thumb
  final double thumbRadius;

  //the thickness of the border
  final double thickness;

  //the roundness of the corners
  final double roundness;

  RoundedRectangleSeekbarShape(
      {this.thumbRadius = 0, this.thickness = 0, this.roundness = 6.0});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      bool? isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      double? value,
      double? textScaleFactor,
      Size? sizeWithOverflow,
      TextDirection? textDirection,
      Thumb? thumb,
      bool? isPressed}) {
    final Canvas canvas = context.canvas;

    final rect = Rect.fromCircle(center: center, radius: thumbRadius);

    final roundedRectangle = RRect.fromRectAndRadius(
      Rect.fromPoints(
        Offset(rect.left - 1, rect.top),
        Offset(rect.right + 1, rect.bottom),
      ),
      Radius.circular(roundness),
    );

    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = sliderTheme.thumbColor!
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(roundedRectangle, fillPaint);
    canvas.drawRRect(roundedRectangle, borderPaint);
  }
}
