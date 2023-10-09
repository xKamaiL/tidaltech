import 'package:flutter/cupertino.dart';
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

  BluetoothDevice? get ble => state.ble;

  getStatus() async {
    final t = ble;
    if (t == null) return;
    await t.connect(
      timeout: const Duration(seconds: 10),
      autoConnect: true,
    );
    final services = await t.discoverServices();
    try {
      services.forEach((element) {
        debugPrint("service ${element.uuid.toString()}");
      });
      final service = services.firstWhere((element) =>
          element.uuid.toString() == "399d90e1-16f1-4fe9-8c2c-91058ed7ae4a");
      service.characteristics.forEach((element) {
        debugPrint("characteristic ${element.uuid.toString()} ${element.descriptors}");
        element.read().then((value) {
          // convert to string
          final str = String.fromCharCodes(value);
          debugPrint("value $str");
        });

      });
    } catch (e) {
      debugPrint("service not found");
    }
  }

  void disconnect() {
    state = state.copyWith(ble: null);
  }

  bool isConnected() {
    return state.ble != null;
  }
}
