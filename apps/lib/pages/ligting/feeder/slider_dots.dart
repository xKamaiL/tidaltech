import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tidal_tech/providers/lighting.dart';
import 'package:tidal_tech/theme/colors.dart';
import 'package:niku/namespace.dart' as n;

class SliderDots extends HookConsumerWidget {
  const SliderDots({
    Key? key,
  }) : super(key: key);

  static const double min = 0;
  static const double max = 1440;

  static const buttonSize = 10;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final points = ref.watch(
      timePointsNotifier,
    );

    var active = ref.watch(timePointEditingProvider)?.id;

    void normalizeSlider() {
      // find time point that duplicate
      for (var i = 0; i < points.length; i++) {
        final point = points[i];
        for (var j = 0; j < points.length; j++) {
          final point2 = points[j];
          if (i == j) {
            continue;
          }
          if (point.hour == point2.hour && point.minute == point2.minute) {
            int minutes = point.minutes();
            minutes += 30;
            // adjust +- 30 minutes
            final newPoint = point.copyWith(
              hour: minutes ~/ 60,
              minute: minutes % 60,
            );
            ref.read(timePointsNotifier.notifier).update(i, newPoint);
            return;
          }
        }
      }
    }

    void updateSlider(double dx, double maxWidth) {
      final tapPosition = dx;
      if (tapPosition <= 0 || tapPosition >= maxWidth) {
        return;
      }
      if (active == null) {
        return;
      }

      final point = points[active!];
      int newFullMinutes = (tapPosition / maxWidth * max).round();
      // adjust new Minutes to something nearly every 5 minutes
      if (newFullMinutes % 5 != 0) {
        newFullMinutes -= newFullMinutes % 5;
      }

      // copy old
      final newPoint = point.copyWith(
        hour: newFullMinutes ~/ 60,
        minute: newFullMinutes % 60,
      );

      ref.read(timePointEditingProvider.notifier).set(newPoint);
      ref.read(timePointsNotifier.notifier).update(active!, newPoint);
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
          return;
        }
      }

      return;
      // we disable this feature for now
      // if active value is still active
      final point = points[active!];
      final newMinutes = (tapPosition / maxWidth * max).round();
      final newPoint = point.copyWith(
        hour: newMinutes ~/ 60,
        minute: newMinutes % 60,
      );

      ref.read(timePointsNotifier.notifier).update(active!, newPoint);
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
                    left: ((points[i].minutes()) * maxWidth / max) - 6,
                    child: Container(
                      width: 12,
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
                        color: active == i
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
                    onPanEnd: (details) {
                      normalizeSlider();
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
