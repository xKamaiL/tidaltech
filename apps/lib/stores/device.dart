import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tidal_tech/models/devices.dart';
import 'package:tidal_tech/models/models.dart';
import 'package:tidal_tech/providers/lighting.dart';
import 'package:tidal_tech/stores/lighting.dart';

import '../providers/feeder.dart';

final deviceProvider = StateNotifierProvider<DeviceNotifier, DeviceProvider>(
  (ref) => DeviceNotifier(DeviceProvider(), ref),
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

    final xState = state;
    if (!res.ok) {
      if (res.error?.code == "DEVICE_NOT_FOUND") {
        xState.isNotPair = true;
      } else {
        xState.isError = true;
      }
      xState.isLoading = false;
      state = xState;
      return;
    }
    prefs.setString("deviceId", res.result!.id); //
    xState.isLoading = false;
    xState.isError = false;
    xState.isNotPair = false;
    xState.device = res.result!;
    state = xState;

    ref.read(lightingModeProvider.notifier).setMode(
          res.result!.properties.mode == "schedule"
              ? LightingMode.feed
              : LightingMode.ambient,
        );
    int i = 0;
    final currentTimePoints = ref.read(timePointsNotifier);
    if (currentTimePoints.isNotEmpty) {
      return;
    }

    final tps = res.result!.properties.schedule.points?.map<TimePoint>((t) {
          Map<LED, ColorPoint> defaultTimePointIntensity = {
            LED.white: ColorPoint(LED.white, t.brightness["white"]!),
            LED.blue: ColorPoint(LED.blue, t.brightness["blue"]!),
            LED.royalBlue:
                ColorPoint(LED.royalBlue, t.brightness["royalBlue"]!),
            LED.warmWhite:
                ColorPoint(LED.warmWhite, t.brightness["warmWhite"]!),
            LED.ultraViolet:
                ColorPoint(LED.ultraViolet, t.brightness["ultraViolet"]!),
            LED.red: ColorPoint(LED.red, t.brightness["red"]!),
            LED.green: ColorPoint(LED.green, t.brightness["green"]!),
          };

          int hh = int.parse(t.time.substring(0, 2));
          int mm = int.parse(t.time.substring(3, 5));
          return TimePoint(
            0,
            hh,
            mm,
            defaultTimePointIntensity,
          );
        }).toList(
          growable: true,
        ) ??
        [];

    tps.sort((a, b) {
      if (a.hour == b.hour) return a.minute.compareTo(b.minute);
      return a.hour.compareTo(b.hour);
    });

    for (int i = 0; i < tps.length; i++) {
      tps[i] = tps[i].copyWith(id: i);
    }

    ref.read(timePointsNotifier.notifier).initTimePoint(tps);
    if (tps.isNotEmpty) {
      ref.read(timePointEditingProvider.notifier).set(tps[0]);
    }
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

  Future<void> setStaticColor(int rgb) async {
    await api.updateStaticColor(UpdateStaticColorParam(
      color: rgb,
    ));
    final x = state;
    x.device = x.device!.properties.copyWith(
      color: rgb,
    );

    state = state;
  }

  Future<void> updateSchedule({required List<TimePoint> timePoints}) async {
    final res = await api.updateSchedule(UpdateScheduleParam(
        schedule: DeviceSchedule(
      points: timePoints.map<DeviceTimePoint>((e) {
        return DeviceTimePoint(
          time:
              "${e.hour.toString().padLeft(2, '0')}:${e.minute.toString().padLeft(2, '0')}",
          brightness: {
            "white": e.colors[LED.white]!.intensity,
            "blue": e.colors[LED.blue]!.intensity,
            "royalBlue": e.colors[LED.royalBlue]!.intensity,
            "warmWhite": e.colors[LED.warmWhite]!.intensity,
            "ultraViolet": e.colors[LED.ultraViolet]!.intensity,
            "red": e.colors[LED.red]!.intensity,
            "green": e.colors[LED.green]!.intensity,
          },
        );
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

class DeviceProvider {
  bool isLoading = true;
  DeviceItem? device;
  bool isNotPair = false;
  bool isError = false;
}
