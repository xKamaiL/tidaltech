import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tidal_tech/pages/ligting/feeder/slider_dots.dart';
import 'package:tidal_tech/providers/feeder.dart';
import 'package:tidal_tech/providers/lighting.dart';
import 'package:tidal_tech/theme/colors.dart';
import 'package:niku/namespace.dart' as n;

class TimeScheduleGraph extends HookConsumerWidget {
  const TimeScheduleGraph({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final points = ref.watch(
      timePointsNotifier,
    );
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
                  painter: TimeSchedulePainter(
                    points: points,
                  ),
                ),
              ),
            ),
          ),
        ),
        n.Box(
          //
          const SliderDots(),
        )
          ..bg = ThemeColors.zinc.shade100
          ..mt = 8,
      ],
    );
  }
}

class TimeSchedulePainter extends CustomPainter {
  final List<TimePoint> points;

  TimeSchedulePainter({
    required this.points,
  });

  // 24:00
  // 1 h = 60
  // 1,440 parts
  // but divided by 4
  static const _parts = 1440;

  void _drawGrids(Canvas canvas, Size size) {
    final m = size.width / (_parts / 4);
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
    _drawGrids(canvas, size);
    _drawTimePoints(canvas, size);
  }

  void _drawTimePoints(Canvas canvas, Size size) {
    final m = size.width / (_parts);
    for (var point in points) {
      final x = (point.minutes()) * m;
      // random y
      final y = size.height * (1 - 0.0);
      final paint = Paint()
        ..color = ThemeColors.zinc.shade500
        ..strokeWidth = 2
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(x, y), 5, paint);
    }

    // paralell task

    // draw blue line connect between points
    final bluePoints =
        points.where((element) => element.colors[LED.blue]!.intensity > 0);

    // sort by minutes

    _drawLine(
      canvas,
      size,
      bluePoints
          .map(
            (e) => CoordinateAndIntensity(
                e.minutes(), e.colors[LED.blue]!.intensity),
          )
          .toList()
        ..sort(
          (a, b) => a.x.compareTo(b.x),
        ),
      ledColor[LED.blue]!,
    );
  }

  void _drawLine(Canvas canvas, Size size, List<CoordinateAndIntensity> points,
      Color color) {
    final m = size.width / (_parts);
    final path = Path()..moveTo(0, size.height);
    for (var i = 0; i < points.length; i++) {
      final x = points[i].x * m;
      final y = size.height * (1 - points[i].intensity / 100);
      path.lineTo(x, y);
    }
    path.lineTo(size.width, size.height);
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CoordinateAndIntensity {
  final int x;
  final int intensity;

  CoordinateAndIntensity(this.x, this.intensity);
}
