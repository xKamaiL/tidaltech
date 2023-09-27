import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothDevice {
  final String name;
  final String id;
  final BluetoothDeviceType type;

  BluetoothDevice({
    required this.name,
    required this.id,
    required this.type,
  });
}

class BleService {
  final List<BluetoothDevice> devicesList = [];

}
