import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

    return LineChart(
      LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        lineBarsData: getLineBars(points),
        minX: 0,
        maxX: 1440,
        clipData: FlClipData.none(),
        maxY: 100,
        minY: 0,
        backgroundColor: ThemeColors.black,
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
    return LineChartBarData(
      isCurved: true,
      curveSmoothness: 0.35,
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

  LineTouchData get lineTouchData1 => LineTouchData(
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
              strokeWidth: 4,
            ),
            FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
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
            const textStyle = TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            );
            return LineTooltipItem(
              '${touchedSpot.y.toInt()}',
              textStyle,
            );
          }).toList();
        },
      ));

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

  void handleTouch(FlTouchEvent events, LineTouchResponse? l) {
    //
    if (events is FlTapUpEvent && l != null && l.lineBarSpots != null) {
      // for (var i = 0; i < l.lineBarSpots!.length; i++) {
      //   print(l.lineBarSpots?[i].spotIndex);
      // }
      return;
    }
    if (events is FlPanStartEvent) {
      debugPrint("start");
      return;
    }

    if (events is FlPanUpdateEvent) {
      int minutes = events.details.globalPosition.dx.round();
      int hh = minutes ~/ 60;
      int mm = minutes % 60;
      debugPrint("hh:mm $hh:$mm");
      return;
    }
  }
}
