import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/providers/feeder.dart';
import 'package:tidal_tech/providers/lighting.dart';
import 'package:tidal_tech/theme/colors.dart';

class Bar extends HookConsumerWidget {
  final LED color;
  final int value;
  final ValueChanged<dynamic>? onChange;

  const Bar(this.color, this.value, this.onChange, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popup = useState(false);
    final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();

    return Expanded(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: n.Text("$value%")
              ..color = ThemeColors.zinc
              ..fontWeight = FontWeight.w900
              ..ml = 8
              ..fontSize = 12,
          ),
          SizedBox(
            width: double.infinity,
            child: CupertinoSlider(
              value: value.toDouble(),
              onChanged: (double value) {
                tooltipkey.currentState?.ensureTooltipVisible();
                popup.value = true;
                // setTimeout to hide popup
                Future.delayed(const Duration(milliseconds: 500), () {
                  popup.value = false;
                });
                onChange!(value);
              },
              max: 100,
              min: 0,
              activeColor: ledColor[color],
              thumbColor: ledColor[color]!,
            ),
          ),
        ],
      ),
    );

    // random value
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
