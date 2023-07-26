import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tidal_tech/theme/colors.dart';
import 'package:niku/namespace.dart' as n;

class TimeScheduleGraph extends HookConsumerWidget {
  const TimeScheduleGraph({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _value = useState(0.0);
    return Column(
      children: [
        SizedBox(
          // rounded
          height: 150,
          width: double.infinity,
          child: Container(
            // rounded corners
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              color: ThemeColors.zinc.shade100,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 1,
                ),
                child: CustomPaint(
                  painter: TimeSchedulePainter(),
                ),
              ),
            ),
          ),
        ),
        n.Box(
          //
          SliderDots(),
        )..bg = ThemeColors.zinc.shade100,
      ],
    );
  }
}

class TimeSchedulePainter extends CustomPainter {
  // 24:00
  // 1 h = 60
  // 1,440 parts
  static const _parts = 1440;
  
  void _drawGrids(Canvas canvas, Size size){
    final m = size.width / _parts;
    final grid = Paint()
      ..color = ThemeColors.zinc.shade300.withOpacity(0.3)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    // draw a grids line for every 60 min
    for (var i = 0; i < _parts; i++) {
      if (i % 60 == 0) {
        canvas.drawLine(Offset(m * i, 0), Offset(m * i, size.height), grid);
      }
    }
    // draw a grids line every 20 percents (vertical)
    for (var i = 0; i < 10; i++) {
      canvas.drawLine(
        Offset(0, size.height * (i / 10)),
        Offset(size.width, size.height * (i / 10)),
        grid,
      );
    }
  }
  @override
  void paint(Canvas canvas, Size size) {
    final m = size.width / _parts;
    _drawGrids(canvas, size);
    

    final paint = Paint()
      ..color = const Color(0xFF4169E1)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    // start from 0 and move to 4:00
    // 240 min

    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(m * 240, size.height)
      ..lineTo(m * 240, size.height * 0.4)
      ..lineTo(m * (240 + 240), 0) // 8:00 100%
      ..lineTo(m * (240 + 240 + (8 * 60)), 0)
      ..lineTo(size.width, size.height); // 18:00 100%

    final redPath = Path()
      ..moveTo(0, size.height)
      ..lineTo(m * 240, size.height)
      ..lineTo(m * 240, size.height * (1 - 0.2))
      ..lineTo(m * (240 + 240), size.height * (1 - 0.8)) // 8:00 100%
      ..lineTo(m * (240 + 240 + (8 * 60)), size.height * (1 - 0.8))
      ..lineTo(size.width, size.height); // 18:00 100%


    canvas.drawPath(path, paint);
    canvas.drawPath(redPath, paint..color = const Color(0xFFFF0000));

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SliderDots extends StatefulWidget {
  const SliderDots({
    Key? key,
  }) : super(key: key);

  static const double min = 0;
  static const double max = 1440;

  @override
  State<SliderDots> createState() => _SliderDotsState();
}

class _SliderDotsState extends State<SliderDots> {
  //* Update sldier
  void _updateSlider(double dx, double maxWidth) {
    final tapPosition = dx;

    //* update logic
    if (tapPosition <= 0 || tapPosition >= maxWidth) {
      return;
    }
  }

  //round number
  double dp(double val, {int places = 2}) {
    num mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }

  //* calculate slider value
  double _generateSliderValue({
    required double maxWidth,
    required double x,
  }) {
    // x is slider original position on width:maxWidth
    return (SliderDots.max - SliderDots.min) * (x / maxWidth) + SliderDots.min;
  }

  //* select ActiveSlider, fixed overLap issue
  //* slider Selector logic
  void _selectSlider({
    required double maxWidth,
    required double tapPosition,
  }) {
    final maxArea = maxWidth * 0.5;

    // if ((tapPosition - x!).abs() < maxArea) {
    //   setState(() {
    //     activeSliderNumber = 0;
    //   });
    // } else if ((tapPosition - y!).abs() < maxArea) {
    //   setState(() {
    //     activeSliderNumber = 1;
    //   });
    // } else if ((tapPosition - z!).abs() < maxArea) {
    //   setState(() {
    //     activeSliderNumber = 2;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 50,
          child: LayoutBuilder(builder: (context, constraints) {
            final maxWidth = constraints.maxWidth - 10;
            return Stack(
              alignment: Alignment.center,
              children: [
                Divider(
                  endIndent: 10,
                  indent: 10,
                  color: ThemeColors.mutedForeground,
                  thickness: 0.1,
                ),
                Positioned(
                  left: maxWidth * 0.2,
                  child: Container(
                    width: 20,
                    height: 20,
                    // shadow
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  left: maxWidth * 0.95,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  left: maxWidth * 0.5,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                GestureDetector(
                  onTapDown: (details) => _selectSlider(
                      maxWidth: maxWidth,
                      tapPosition: details.localPosition.dx),
                  onPanUpdate: (details) =>
                      _updateSlider(details.localPosition.dx, maxWidth),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}
