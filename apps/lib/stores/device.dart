import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tidal_tech/models/devices.dart';
import 'package:tidal_tech/models/models.dart';

class DeviceProvider {
  bool isLoading = true;
  DeviceItem? device;
  bool isNotPair = false;
  bool isError = false;
}

class DeviceNotifier extends StateNotifier<DeviceProvider> {
  DeviceNotifier(super.state);

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

//
}

final deviceProvider = StateNotifierProvider<DeviceNotifier, DeviceProvider>(
  (ref) => DeviceNotifier(DeviceProvider()),
);
