import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ScannerDeviceItem {
  final BluetoothDevice device;
  final int rssi;

  ScannerDeviceItem(this.device, this.rssi);
}

final scannerProvider =
    StateNotifierProvider<Scanner, List<ScannerDeviceItem>>((ref) {
  return Scanner();
});

class Scanner extends StateNotifier<List<ScannerDeviceItem>> {
  Scanner() : super([]);

  void addDevice(BluetoothDevice device, int rssi) {
    if (state.any((element) => element.device.remoteId == device.remoteId)) {
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
