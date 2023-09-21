import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../providers/feeder.dart';
import '../../../providers/lighting.dart';
import '../../../theme/colors.dart';

class ShowLineChart extends HookConsumerWidget {
  const ShowLineChart({
    super.key,
  });

  final bool isShowingMainData = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final points = ref.watch(
      timePointsNotifier,
    );

    void handleTouch(FlTouchEvent events, LineTouchResponse? l) {
      //
      if (events is FlTapUpEvent && l != null && l.lineBarSpots != null) {
        if (l.lineBarSpots!.isEmpty) return;
        int minutes = l.lineBarSpots?[0].x.round() ?? 0;
        if (minutes == 0) return;
        try {
          final tp =
              points.firstWhere((element) => element.minutes() == minutes);
          ref.read(timePointEditingProvider.notifier).set(tp);
        } catch (e) {
          return;
        }
        // for (var i = 0; i < l.lineBarSpots!.length; i++) {
        //   print(l.lineBarSpots?[i].spotIndex);
        // }
        return;
      }



    }

    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          enabled: true,
          handleBuiltInTouches: true,
          touchCallback: (FlTouchEvent events, LineTouchResponse? l) {
            handleTouch(events, l);
          },
          getTouchedSpotIndicator:
              (LineChartBarData barData, List<int> spotIndexes) {
            return spotIndexes.map((spotIndex) {
              return TouchedSpotIndicatorData(
                const FlLine(
                  color: ThemeColors.primary,
                  strokeWidth: 8,
                ),
                FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 6,
                      color: barData.color ?? ThemeColors.primary,
                      strokeWidth: 0,
                    );
                  },
                ),
              );
            }).toList();
          },
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: ThemeColors.foreground,
            tooltipHorizontalAlignment: FLHorizontalAlignment.left,
            tooltipMargin: 16,
            tooltipRoundedRadius: 16,
            tooltipPadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            tooltipHorizontalOffset: -10,
            fitInsideVertically: true,
            fitInsideHorizontally: true,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((LineBarSpot touchedSpot) {
                final textStyle = TextStyle(
                  color: touchedSpot.bar.color ?? ThemeColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                );
                return LineTooltipItem(
                  '${touchedSpot.y.toInt()} %',
                  textStyle,
                );
              }).toList();
            },
          ),
        ),
        gridData: gridData,
        titlesData: titlesData1,
        lineBarsData: getLineBars(points),
        minX: 0,
        maxX: 1440,
        clipData: const FlClipData.none(),
        maxY: 100,
        minY: 0,
        backgroundColor: ThemeColors.zinc.shade900,
      ),
      duration: const Duration(milliseconds: 250),
      curve: Curves.decelerate,
    );
  }

  List<LineChartBarData> getLineBars(List<TimePoint> tps) {
    return [
      drawLineFromColor(LED.white, tps),
      drawLineFromColor(LED.blue, tps),
      drawLineFromColor(LED.royalBlue, tps),
      drawLineFromColor(LED.warmWhite, tps),
      drawLineFromColor(LED.ultraViolet, tps),
      drawLineFromColor(LED.red, tps),
      drawLineFromColor(LED.green, tps),
    ];
  }

  LineChartBarData drawLineFromColor(LED color, List<TimePoint> tps) {
    tps.sort(
      (a, b) => a.minutes().compareTo(b.minutes()),
    );
    return LineChartBarData(
      isCurved: true,
      curveSmoothness: 0.33,
      preventCurveOverShooting: true,
      preventCurveOvershootingThreshold: 0.01,
      gradient: LinearGradient(
        colors: [
          ledColor[color]!.withOpacity(0.5),
          ledColor[color]!.withOpacity(1),
        ],
        stops: const [
          0.05,
          0.9,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ),
      color: ledColor[color],
      barWidth: 2,
      isStrokeCapRound: true,
      isStrokeJoinRound: true,
      dotData: FlDotData(
        show: true,
        // remove dot at the end and start
        checkToShowDot: (spot, barData) {
          return spot.x != 0 && spot.x != 1440;
        },
        getDotPainter: (spot, percent, barData, index) {
          return FlDotCirclePainter(
            radius: 5,
            color: ledColor[color]!,
            strokeWidth: 0,
          );
        },
      ),
      belowBarData: BarAreaData(
        show: true,
        color: ledColor[color]!.withOpacity(
          ColorPriority(color).getOpacity(),
        ),
      ),
      spots: [
        const FlSpot(0, 0),
        // sort timePoint by minutes
        ...tps.map((tp) {
          return FlSpot(
            tp.minutes().toDouble(),
            tp.colors[color]!.intensity.toDouble(),
          );
        }).toList(),
        //
        const FlSpot(1440, 0),
      ],
    );
  }

  FlTitlesData get titlesData1 => const FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      );

  FlGridData get gridData => const FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: true,
        verticalInterval: 1440 / 24 * 4,
      );
}
