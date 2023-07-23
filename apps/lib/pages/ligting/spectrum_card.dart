import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:flutter_hooks/flutter_hooks.dart';

class SpectrumCard extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          n.Padding(
            child: n.Text("Spectrum Colors")
              ..fontSize = 24
              ..bold
              ..color = Colors.white,
          )..p = 8,
          n.Padding(
            child: n.Row(const [
              Bar(
                Colors.pink,
              ),
              Bar(
                Colors.purple,
              ),
              Bar(
                Colors.indigo,
              ),
              Bar(
                Colors.blueAccent,
              ),
              Bar(
                Colors.lightBlue,
              ),
              Bar(
                Colors.lightBlueAccent,
              ),
              Bar(
                Colors.green,
              ),
              Bar(
                Colors.grey,
              ),
              Bar(
                Colors.red,
              ),
              Bar(
                Colors.lightBlue,
              ),
              Bar(
                Colors.black26,
              ),
            ])
              ..spaceBetween
              ..p = 0
              ..gap = 0,
          )
            ..p = 8
            ..mt = 12
        ],
      ),
    );
  }
}

class Bar extends HookConsumerWidget {
  final Color color;

  const Bar(this.color, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final v = useState<double>(0.5);
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: RotatedBox(
        quarterTurns: 3,
        child: SliderTheme(
            data: SliderThemeData(
              thumbColor: Colors.transparent,
              overlayColor: Colors.transparent,
              trackHeight: 24,
              thumbShape: SliderComponentShape.noThumb,
              overlayShape: RoundedRectangleSeekbarShape(
              ),
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

    // canvas.drawRRect(roundedRectangle, fillPaint);
    // canvas.drawRRect(roundedRectangle, borderPaint);
  }
}