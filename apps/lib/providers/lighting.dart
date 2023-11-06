import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tidal_tech/providers/feeder.dart';

final timePointsProvider = timePointsNotifier;

final timePointsNotifier =
    StateNotifierProvider<TimePointsNotifier, List<TimePoint>>((ref) {
  return TimePointsNotifier(ref);
});

class TimePointsNotifier extends StateNotifier<List<TimePoint>> {
  final Ref ref;

  TimePointsNotifier(this.ref) : super([]);

  void initTimePoint(List<TimePoint> tps) {
    state = tps;
  }

  void addTimePoint() {
    if (state.isEmpty) {
      state = [
        const TimePoint(
          0,
          5, // 5:00
          0,
          defaultTimePointIntensity,
        )
      ];
      // prefer to select the first time point
      // for better ux
      ref.read(timePointEditingProvider.notifier).set(state[0]);
      return;
    }

    // limit to 10 time points
    if (state.length > 10) {
      return;
    }

    int minutes = state.last.minutes();

    debugPrint('minutes: $minutes');

    if (minutes >= 1440) {
      return;
    }

    if (state.length <= 5) {
      minutes += 60 * 3; // 3 hours
    } else {
      minutes += 30; // 1 hour
    }

    final hour = (minutes / 60).floor();
    final minute = minutes % 60;
    state = [
      ...state,
      TimePoint(
        state.length,
        hour,
        minute,
        state.last.colors, // copy from last time point
      ),
    ];
    // prefer to select the last time point
    ref.read(timePointEditingProvider.notifier).set(state.last);

    return;
  }

  void update(int id, TimePoint tp) {
    // optimize ?
    if (state.length == 1) {
      state = [tp];
      return;
    }

    // check if new value is duplicate hh:mm with other time point
    final duplicate = state.where((element) {
      return element.id != id &&
          element.hour == tp.hour &&
          element.minute == tp.minute;
    }).toList();
    if (duplicate.isNotEmpty) {
      return;
    }

    final newTps = state.map((e) {
      if (e.id == id) {
        return tp;
      }
      return e;
    }).toList();

    // sort
    newTps.sort((a, b) => a.minutes().compareTo(b.minutes()));

    // update id
    final newState = newTps.map((e) {
      final id = newTps.indexOf(e);
      return e.copyWith(id: id);
    }).toList();

    state = newState;
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

    final tmp =
        state.where((element) => element.minutes() != tp.minutes()).toList();

    // sort
    tmp.sort((a, b) => a.minutes().compareTo(b.minutes()));

    // update id
    final newState = tmp.map((e) {
      final id = tmp.indexOf(e);
      print(id);
      return e.copyWith(id: id);
    }).toList();

    state = newState;
  }

  void editNext() {
    if (state.isEmpty) {
      return;
    }
    final current = ref.read(timePointEditingProvider);
    if (current == null) {
      return;
    }
    if (current.id == state.length - 1) {
      return;
    }
    final next = findById(current.id + 2);
    if (next == null) {
      return;
    }
    ref.read(timePointEditingProvider.notifier).set(next);
  }

  void editPrevious() {
    if (state.isEmpty) return;
    final current = ref.read(timePointEditingProvider);
    if (current == null) return;
    if (current.id == 0) return;
    final previous = findById(current.id);
    if (previous == null) return;
    ref.read(timePointEditingProvider.notifier).set(previous);
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
