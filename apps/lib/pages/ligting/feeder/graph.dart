import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
          SliderDots(),
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
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SliderDots extends HookConsumerWidget {
  const SliderDots({
    Key? key,
  }) : super(key: key);

  static const double min = 0;
  static const double max = 1440;

  static const buttonSize = 10;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final active = useState<int?>(null);

    final points = ref.watch(
      timePointsNotifier,
    );

    void updateSlider(double dx, double maxWidth) {
      final tapPosition = dx;
      if (tapPosition <= 0 || tapPosition >= maxWidth) {
        return;
      }
      if (active.value == null) {
        return;
      }

      final point = points[active.value!];
      int newMinutes = (tapPosition / maxWidth * max).round();
      // adjust new Minutes to something nearly every 5 minutes
      if (newMinutes % 5 != 0) {
        newMinutes -= newMinutes % 5;
      }
      final newPoint = point.copyWith(
        hour: newMinutes ~/ 60,
        minute: newMinutes % 60,
      );
      ref.read(timePointEditingProvider.notifier).set(newPoint);
      ref.read(timePointsNotifier.notifier).update(active.value!, newPoint);
    }

    void selectSlider({
      required double maxWidth,
      required double tapPosition,
    }) {
      // if points is empty
      if (points.isEmpty) {
        return;
      }
      // if tapPosition is out of bound
      if (tapPosition <= 0 || tapPosition >= maxWidth) {
        return;
      }

      // for loop with index
      for (var i = 0; i < points.length; i++) {
        final point = points[i];
        final x = (point.minutes()) * maxWidth / max;
        if ((tapPosition - x).abs() < buttonSize) {
          ref.read(timePointEditingProvider.notifier).set(point);
          active.value = i;
          return;
        }
      }
      if (active.value == null) {
        ref.read(timePointEditingProvider.notifier).remove();
        return;
      }

      return;
      // we disable this feature for now
      // if active value is still active
      final point = points[active.value!];
      final newMinutes = (tapPosition / maxWidth * max).round();
      final newPoint = point.copyWith(
        hour: newMinutes ~/ 60,
        minute: newMinutes % 60,
      );

      ref.read(timePointsNotifier.notifier).update(active.value!, newPoint);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 50,
          child: LayoutBuilder(builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            return Stack(
              alignment: Alignment.center,
              children: [
                const Divider(
                  endIndent: 0,
                  indent: 0,
                  color: ThemeColors.mutedForeground,
                  thickness: 0.1,
                ),

                // loop TimePoint here
                for (var i = 0; i < points.length; i++)
                  Positioned(
                    // -5 because we want to center the dot
                    left: ((points[i].minutes()) * maxWidth / max) - 5,
                    child: Container(
                      width: 10,
                      height: 30,

                      // shadow
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: ThemeColors.white,
                            blurRadius: 100,
                            spreadRadius: 5,
                          ),
                        ],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        color: active.value == i
                            ? ThemeColors.primary
                            : ThemeColors.zinc.shade500,
                      ),
                    ),
                  ),
                SizedBox.expand(
                  child: GestureDetector(
                    onTapDown: (details) => selectSlider(
                        maxWidth: maxWidth,
                        tapPosition: details.localPosition.dx),
                    onPanUpdate: (details) =>
                        updateSlider(details.localPosition.dx, maxWidth),
                    onPanStart: (details) {
                      updateSlider(details.localPosition.dx, maxWidth);
                    },
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}
