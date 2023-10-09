import 'package:flutter/cupertino.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const String _serviceUUID = "0000ffe0-0000-1000-8000-00805f9b34fb";
const String bleName = "iPad g"; // "Tidal Tech";

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

    // // device.servicesList
    // for (final service in await device.discoverServices()) {
    //   debugPrint("service ${service.uuid}");
    // }

    debugPrint("add device ${device.remoteId}");
    state = [...state, ScannerDeviceItem(device, 0)];
  }

  void removeDevice(BluetoothDevice device) {
    state = state
        .where((element) => element.device.remoteId != device.remoteId)
        .toList();
  }
}
