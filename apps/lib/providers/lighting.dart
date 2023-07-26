import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tidal_tech/pages/ligting/lighting.dart';
import 'package:tidal_tech/providers/feeder.dart';
import 'package:tidal_tech/stores/lighting.dart';

final lightingProvider =
    StateNotifierProvider<LightingNotifier, LightingSetting>((ref) {
  return LightingNotifier(LightingSetting(
    LightingMode.feed,
    FeederConfig([]),
    null,
  ));
});

@immutable
class LightingSetting {
  const LightingSetting(this.currentMode, this.feederConfig, this.selectedTime);

  // config from database
  final LightingMode currentMode;
  final FeederConfig feederConfig;

  // current selected time point
  final HourMinute? selectedTime;

  // copy with new value
  // since this is immutable class
  copyWith({
    LightingMode? currentMode,
    FeederConfig? feederConfig,
    HourMinute? selectedTime,
  }) {
    return LightingSetting(
      currentMode ?? this.currentMode,
      feederConfig ?? this.feederConfig,
      selectedTime ?? this.selectedTime,
    );
  }
}

class LightingNotifier extends StateNotifier<LightingSetting> {
  LightingNotifier(super.state);

  void update() {
    state = state;
  }

  TimePoint? getEditingTimePoint() {
    if (state.selectedTime == null) {
      return null;
    }
    // find TimePoint by hh:mm
    // or return null if not found
    for (var point in state.feederConfig.points) {
      if (point.hour == state.selectedTime!.hour &&
          point.minute == state.selectedTime!.minute) {
        return point;
      }
    }
    return null;
  }

  void selectEditTime(HourMinute time) {
    state = state.copyWith(selectedTime: time);
  }

  void changeMode(LightingMode mode) {
    state = state.copyWith(currentMode: mode);
  }

  void changeFeederConfig(FeederConfig config) {
    state = state.copyWith(feederConfig: config);
  }

  get feederConfig => state.feederConfig;

  void addTimePoint(TimePoint point) {
    state.feederConfig.points.add(point);
    state = state;
  }

  void removeTimePoint(TimePoint point) {
    // remove time point by hh:mm
    state.feederConfig.points.removeWhere((element) {
      return element.hour == point.hour && element.minute == point.minute;
    });
    state = state;
  }
}
