import 'package:flutter/cupertino.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ConnectDeviceData {
  final BluetoothDevice? ble;
  final String id;

  bool firstLoad = true; // initial state

  ConnectDeviceData(this.ble, this.id, {this.firstLoad = false});

  bool isScanning = false;

  copyWith({BluetoothDevice? ble, String? id}) {
    return ConnectDeviceData(ble ?? this.ble, id ?? this.id, firstLoad: false);
  }

}

final connectDeviceProvider =
    StateNotifierProvider<ConnectedDeviceProvider, ConnectDeviceData>((ref) {
  return ConnectedDeviceProvider();
});

class ConnectedDeviceProvider extends StateNotifier<ConnectDeviceData> {
  ConnectedDeviceProvider() : super(ConnectDeviceData(null, ""));

  void set(BluetoothDevice device) {
    state = state.copyWith(ble: device);
  }

  BluetoothDevice? get ble => state.ble;

  Future<String> getStatus() async {
    final t = ble;
    if (t == null) return "no bluetooth is connected";
    await t.connect(
      timeout: const Duration(seconds: 10),
      autoConnect: true,
    );
    final services = await t.discoverServices();
    var result = "";
    try {
      services.forEach((element) {
        debugPrint("service ${element.uuid.toString()}");
      });
      final service = services.firstWhere((element) =>
          element.uuid.toString() == "399d90e1-16f1-4fe9-8c2c-91058ed7ae4a");
      for (var element in service.characteristics) {
        final str = String.fromCharCodes(await element.read());
        return str;
      }
      return result;
    } catch (e) {
      print(e);
      return "service not found";
    }
  }

  void disconnect() {
    state = state.copyWith(ble: null);
  }

  bool isConnected() {
    return state.ble != null;
  }

  void startScan() {
    state.isScanning = true;
  }

  void stopScan() {
    state.isScanning = false;
  }
}
