import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ConnectDeviceData {
  final BluetoothDevice? ble;
  final String id;

  ConnectDeviceData(this.ble, this.id);

  copyWith({BluetoothDevice? ble, String? id}) {
    return ConnectDeviceData(ble ?? this.ble, id ?? this.id);
  }
}

final connectDeviceProvider =
    StateNotifierProvider<ConnectedDeviceProvider, ConnectDeviceData>((ref) {
  return ConnectedDeviceProvider();
});

class ConnectedDeviceProvider extends StateNotifier<ConnectDeviceData> {
  ConnectedDeviceProvider() : super(ConnectDeviceData(null, ""));

  void connect(BluetoothDevice device) {
    state = state.copyWith(ble: device);
  }

  void disconnect() {
    state = state.copyWith(ble: null);
  }

  bool isConnected() {
    return state.ble != null;
  }
}
