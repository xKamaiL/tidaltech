import 'package:flutter/cupertino.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tidal_tech/constants/ble_services_ids.dart';

const String bleName = "TIDAL TECH";

class ScannerDeviceItem {
  final BluetoothDevice device;
  final int rssi;

  ScannerDeviceItem(this.device, this.rssi);
}

class TidalDeviceFilter {
  final String name;
  final String serviceUUID;

  TidalDeviceFilter(this.name, this.serviceUUID);

  static bool ok(BluetoothDevice device) {
    return device.localName.startsWith(bleName, 0);
  }
}

final scannerProvider =
    StateNotifierProvider<Scanner, List<ScannerDeviceItem>>((ref) {
  return Scanner();
});

class Scanner extends StateNotifier<List<ScannerDeviceItem>> {
  Scanner() : super([]);

  void clearDevices() {
    state = [];
  }

  void addDevice(BluetoothDevice device, int rssi) async {
    if (state.any((element) => element.device.remoteId == device.remoteId)) {
      return;
    }
    if (device.localName.isEmpty) {
      return;
    }

    if (!TidalDeviceFilter.ok(device)) {
      return;
    }

    state = [...state, ScannerDeviceItem(device, 0)];
  }

  void removeDevice(BluetoothDevice device) {
    state = state
        .where((element) => element.device.remoteId != device.remoteId)
        .toList();
  }
}
