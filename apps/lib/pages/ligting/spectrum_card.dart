import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:flutter_hooks/flutter_hooks.dart';

class SpectrumCard extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return n.Column([
      n.Text("Spectrum")
        ..fontSize = 18
        ..color = Colors.white
        ..fontWeight = FontWeight.bold,
      n.Row(List.generate(
          7, (index) => n.Text("${index * 4}:00")..color = Colors.white))
        ..spaceBetween
        ..wFull
        ..gap = 4,
    ])
      ..wFull
      ..crossAxisAlignment = CrossAxisAlignment.start
      ..mainAxisAlignment = MainAxisAlignment.start
      ..pb = 16
      ..gap = 4;
  }
}

class Bar extends HookConsumerWidget {
  final Color color;

  const Bar(this.color, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // random value

    final v = useState<double>(Random().nextDouble() * 1);
    final percent = (v.value * 100).toInt();
    return Stack(alignment: Alignment.bottomCenter, children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 0, top: 24),
        child: SliderTheme(
            data: SliderThemeData(
              thumbColor: Colors.transparent,
              overlayColor: Colors.transparent,
              trackHeight: 24,
              thumbShape: SliderComponentShape.noThumb,
              overlayShape: RoundedRectangleSeekbarShape(),
            ),
            child: Slider(
              activeColor: color,
              inactiveColor: color.withOpacity(0.35),
              value: v.value,
              onChanged: (vv) {
                v.value = vv;
              },
              min: 0,
            )),
      ),
      Container(
        padding: EdgeInsets.only(top: 10),
        alignment: Alignment.bottomCenter,
        child: n.Text("$percent%")
          ..fontSize = 10
          ..color = Colors.white,
      ),
    ]);
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

    // canvas.drawRRect(roundedRectangle, fillPaint);
    // canvas.drawRRect(roundedRectangle, borderPaint);
  }
}
