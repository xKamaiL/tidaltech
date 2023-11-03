import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tidal_tech/models/devices.dart';
import 'package:tidal_tech/models/models.dart';

class DeviceProvider {
  bool isLoading = true;
  DeviceItem? device;
  bool isNotPair = false;
}

class DeviceNotifier extends StateNotifier<DeviceProvider> {
  DeviceNotifier(super.state);

  Future<void> fetchCurrentDevice() async {
    print("fetchCurrentDevice");
    final res = await api.fetchDevice(PairParam(id: "id"));
    state.isLoading = false;
    if (!res.ok) {
      if (res.error?.code == "DEVICE_NOT_FOUND") {
        state.isNotPair = true;
      } else {
        print(res.error!.message);
      }
      state = state;
      return;
    }
    print("fetchCurrentDevice: ok");
    state.isNotPair = false;
    state.device = res.result!;
    state = state;
  }

//
}

final deviceProvider = StateNotifierProvider<DeviceNotifier, DeviceProvider>(
  (ref) => DeviceNotifier(DeviceProvider()),
);
