import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tidal_tech/pages/ligting/lighting.dart';
import 'package:tidal_tech/providers/feeder.dart';
import 'package:tidal_tech/stores/lighting.dart';

// Finally, we are using StateNotifierProvider to allow the UI to interact with
// our TodosNotifier class.
final timePointsNotifier =
    StateNotifierProvider<TimePointsNotifier, List<TimePoint>>((ref) {
  return TimePointsNotifier(ref);
});

class TimePointsNotifier extends StateNotifier<List<TimePoint>> {
  final Ref ref;
  TimePointsNotifier( this.ref) : super([]);

  void addTimePoint() {
    if (state.isEmpty) {
      state = [
        const TimePoint(
          0,
          1, // 1:00
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
        state.length,
        hour,
        minute,
        defaultTimePointIntensity,
      ),
    ];



    return;
  }

  void update(int i, TimePoint tp) {
    // optimize ?

    state = [
      ...state.sublist(0, i),
      tp,
      ...state.sublist(i + 1),
    ];
  }

  TimePoint? findById(int id) {
    try {
      final tp = state[id - 1];
      return tp;
    } catch (e) {
      return null;
    }
  }

  void updateColor(int hour, int minute, LED led, dynamic value) {
    final tp = state.firstWhere(
      (element) => element.hour == hour && element.minute == minute,
    );
    final newTp = tp.copyWith(
      colors: {
        ...tp.colors,
        led: tp.colors[led]!.copyWith(intensity: value),
      },
    );
    update(state.indexOf(tp), newTp);
  }

  void delete(TimePoint? tp) {
    if (tp == null) return;
    state = state.where((element) => element.minutes() != tp.minutes()).toList();
  }
}

const Map<LED, ColorPoint> defaultTimePointIntensity = {
  LED.white: ColorPoint(LED.white, 0),
  LED.blue: ColorPoint(LED.blue, 0),
  LED.royalBlue: ColorPoint(LED.royalBlue, 0),
  LED.warmWhite: ColorPoint(LED.warmWhite, 0),
  LED.ultraViolet: ColorPoint(LED.ultraViolet, 0),
  LED.red: ColorPoint(LED.red, 0),
  LED.green: ColorPoint(LED.green, 0),
};

final timePointEditingProvider =
    StateNotifierProvider<TimePointEditing, TimePoint?>(
  (ref) => TimePointEditing(ref),
);

class TimePointEditing extends StateNotifier<TimePoint?> {
  final Ref ref;

  TimePointEditing(this.ref) : super(null);

  set(TimePoint tp) {
    state = tp;
  }

  remove() {
    state = null;
  }

  void updateBlue(double value) {
    _updateColor(LED.blue, value.round());
  }

  void updateRoyalBlue(double value) {
    _updateColor(LED.royalBlue, value.round());
  }

  void updateWhite(double value) {
    _updateColor(LED.white, value.round());
  }

  void updateWarmWhite(double value) {
    _updateColor(LED.warmWhite, value.round());
  }

  void updateUltraViolet(double value) {
    _updateColor(LED.ultraViolet, value.round());
  }

  void updateRed(double value) {
    _updateColor(LED.red, value.round());
  }

  void updateGreen(double value) {
    _updateColor(LED.green, value.round());
  }

  void _updateColor(LED led, int v) {
    if (state == null) return;

    // update editing state
    state = state!.copyWith(
      colors: {
        ...state!.colors,
        led: state!.colors[led]!.copyWith(intensity: v),
      },
    );
    // update
    ref.read(timePointsNotifier.notifier).updateColor(
          state!.hour,
          state!.minute,
          led,
          v,
        );
  }
}
