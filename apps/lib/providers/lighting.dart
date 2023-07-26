import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tidal_tech/pages/ligting/lighting.dart';
import 'package:tidal_tech/providers/feeder.dart';
import 'package:tidal_tech/stores/lighting.dart';

final lightingProvider =
    StateNotifierProvider<LightingNotifier, LightingSetting>((ref) {
  return LightingNotifier(LightingSetting());
});

class LightingSetting {
  LightingSetting();

  // config from database
  late LightingMode currentMode;
  late FeederConfig feederConfig;

  // current selected time point
  late HourMinute? selectedTime;
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
    state.selectedTime = time;
    state = state;
  }

  void changeMode(LightingMode mode) {
    state.currentMode = mode;
    state = state;
  }

  void changeFeederConfig(FeederConfig config) {
    state.feederConfig = config;
    state = state;
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
