import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tidal_tech/pages/ligting/lighting.dart';
import 'package:tidal_tech/providers/feeder.dart';
import 'package:tidal_tech/stores/lighting.dart';

// Finally, we are using StateNotifierProvider to allow the UI to interact with
// our TodosNotifier class.
final timePointsNotifier =
    StateNotifierProvider<TimePointsNotifier, List<TimePoint>>((ref) {
  return TimePointsNotifier();
});

class TimePointsNotifier extends StateNotifier<List<TimePoint>> {
  TimePointsNotifier() : super([]);

  void addTimePoint() {
    if (state.isEmpty) {
      state = [
        TimePoint(
          0,
          0,
          defaultTimePointIntensity,
        )
      ];
      return;
    }

    // limit to 10 time points
    if (state.length > 10) {
      return;
    }

    int minutes = state.last.minutes();

    if (minutes == 1440) return;

    minutes += 60;

    final hour = (minutes / 60).floor();
    final minute = minutes % 60;
    state = [
      ...state,
      TimePoint(
        hour,
        minute,
        defaultTimePointIntensity,
      ),
    ];
    return;
  }
}

const defaultTimePointIntensity = <Map<LED, ColorPoint>>[
  {
    LED.white: ColorPoint(LED.white, 0),
    LED.blue: ColorPoint(LED.blue, 0),
    LED.royalBlue: ColorPoint(LED.royalBlue, 0),
    LED.warmWhite: ColorPoint(LED.warmWhite, 0),
    LED.ultraViolet: ColorPoint(LED.ultraViolet, 0),
    LED.red: ColorPoint(LED.red, 0),
    LED.green: ColorPoint(LED.green, 0),
  }
];
