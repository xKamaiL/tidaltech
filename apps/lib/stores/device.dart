import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tidal_tech/models/devices.dart';
import 'package:tidal_tech/models/models.dart';
import 'package:tidal_tech/providers/lighting.dart';
import 'package:tidal_tech/stores/lighting.dart';
import 'package:tidal_tech/stores/static_led_mode.dart';

import '../providers/feeder.dart';

final deviceProvider = StateNotifierProvider<DeviceNotifier, DeviceProvider>(
  (ref) => DeviceNotifier(
      DeviceProvider(
        isLoading: true,
        isNotPair: false,
        isError: false,
      ),
      ref),
);

class DeviceNotifier extends StateNotifier<DeviceProvider> {
  final Ref ref;

  DeviceNotifier(
    super.state,
    this.ref,
  );

  Future<void> fetchCurrentDevice() async {
    final prefs = await SharedPreferences.getInstance();
    final res = await api.fetchDevice(PairParam(id: "id"));

    var xState = state;
    if (!res.ok) {
      if (res.error?.code == "DEVICE_NOT_FOUND") {
        xState = xState.copyWith(isNotPair: true);
      } else {
        xState.copyWith(isError: true);
      }
      xState.copyWith(isLoading: false);
      state = xState;
      return;
    }
    prefs.setString("deviceId", res.result!.id); //
    xState = xState.copyWith(
        isLoading: false,
        isError: false,
        isNotPair: false,
        device: res.result!);
    state = xState;

    ref.read(lightingModeProvider.notifier).setMode(
          res.result!.properties.mode == "schedule"
              ? LightingMode.feed
              : LightingMode.ambient,
        );

    if (res.result!.properties.colors != null) {
      ref.read(staticLEDColorProvider.notifier).setWhite(
            res.result!.properties.colors!["white"]!.toDouble(),
          );
      ref.read(staticLEDColorProvider.notifier).setBlue(
            res.result!.properties.colors!["blue"]!.toDouble(),
          );
      ref.read(staticLEDColorProvider.notifier).setRoyalBlue(
            res.result!.properties.colors!["royalBlue"]!.toDouble(),
          );
      ref.read(staticLEDColorProvider.notifier).setWarmWhite(
            res.result!.properties.colors!["warmWhite"]!.toDouble(),
          );
      ref.read(staticLEDColorProvider.notifier).setUltraViolet(
            res.result!.properties.colors!["ultraViolet"]!.toDouble(),
          );
      ref.read(staticLEDColorProvider.notifier).setRed(
            res.result!.properties.colors!["red"]!.toDouble(),
          );
      ref.read(staticLEDColorProvider.notifier).setGreen(
            res.result!.properties.colors!["green"]!.toDouble(),
          );
    }

    final currentTimePoints = ref.read(timePointsNotifier);
    if (currentTimePoints.isNotEmpty) {
      return;
    }
    final tps = (res.result!.properties.schedule.points ?? []).toList();

    ref.read(timePointsNotifier.notifier).initTimePoint(tps);

    //
  }

  Future<String> forgot() async {
    if (state.device == null) return "no device connected";
    final res = await api.unPair(UnPairParam(id: state.device!.id));
    if (res.ok) {
      return "";
    }
    if (res.error!.code == "DEVICE_NOT_FOUND") return "";
    return res.error!.message ?? "unknown error";
  }

  Future<void> setMode(LightingMode mode) async {
    await api.updateMode(UpdateModeParam(
      mode: mode == LightingMode.feed ? "schedule" : "manual",
    ));
  }

  Future<void> setStaticColor(Map<LED, ColorPoint> colors) async {
    await api.updateStaticColor(UpdateStaticColorParam(
      colors: colors.map((key, value) => MapEntry(key.name, value.intensity)),
    ));

    state = state.copyWith(
        device: state.device!.copyWith(
      properties: state.device!.properties.copyWith(
        color: colors.map((key, value) => MapEntry(key.name, value.intensity)),
      ),
    ));
  }

  Future<void> updateSchedule({required List<TimePoint> timePoints}) async {
    final res = await api.updateSchedule(UpdateScheduleParam(
        schedule: DeviceSchedule(
      points: timePoints.map<DeviceTimePoint>((e) {
        return e.toDeviceTimePoint();
      }).toList(),
      // TODO: add weekday
      weekday: 0,
    )));

    if (!res.ok) {
      debugPrint("updateSchedule: ${res.error?.message}");
      return;
    }
  }

//
}

@immutable
class DeviceProvider {
  final bool isLoading;

  final DeviceItem? device;
  final bool isNotPair;

  final bool isError;

  const DeviceProvider({
    required this.isLoading,
    this.device,
    required this.isNotPair,
    required this.isError,
  });

  copyWith({
    bool? isLoading,
    DeviceItem? device,
    bool? isNotPair,
    bool? isError,
  }) {
    return DeviceProvider(
      isLoading: isLoading ?? this.isLoading,
      device: device ?? this.device,
      isNotPair: isNotPair ?? this.isNotPair,
      isError: isError ?? this.isError,
    );
  }
}
