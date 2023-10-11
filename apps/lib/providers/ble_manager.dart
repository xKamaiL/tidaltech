import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tidal_tech/constants/ble_services_ids.dart';

const String bleName = "TIDAL";

class TidalDeviceFilter {
  final String name;
  final String serviceUUID;

  TidalDeviceFilter(this.name, this.serviceUUID);

  static bool ok(BluetoothDevice device) {
    return device.localName.startsWith(bleName);
  }
}

@immutable
class BLEManager extends Equatable {
  final bool firstLoad = true;

  final List<BluetoothDevice> scanResults;

  final BluetoothDevice? connectedDevice;
  final String connectedDeviceId;

  final bool isScanning;
  final bool isReconnecting;

  final bool isOnline;

  bool get isConnected => connectedDevice != null;

  get scanLength => scanResults.length;

  bool get isDisconnected => connectedDevice == null;

  List<BluetoothDevice> get knownDevices => scanResults;

  const BLEManager(this.scanResults, this.connectedDevice,
      this.connectedDeviceId, this.isScanning, this.isReconnecting,
      {this.isOnline = false});

  BLEManager copyWith({
    List<BluetoothDevice>? scanResults,
    BluetoothDevice? connectedDevice,
    String? connectedDeviceId,
    bool? isScanning,
    bool? isReconnecting,
    bool? isOnline,
  }) {
    return BLEManager(
      scanResults ?? this.scanResults,
      connectedDevice ?? this.connectedDevice,
      connectedDeviceId ?? this.connectedDeviceId,
      isScanning ?? this.isScanning,
      isReconnecting ?? this.isReconnecting,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        scanResults,
        connectedDevice,
        connectedDeviceId,
        isScanning,
        isReconnecting,
        isOnline,
      ];
}

final bleManagerProvider =
    StateNotifierProvider<BLEManagerProvider, BLEManager>((ref) {
  //
  return BLEManagerProvider();
});

class BLEManagerProvider extends StateNotifier<BLEManager> {
  BLEManagerProvider() : super(const BLEManager([], null, "", false, false));

  void init() {
    debugPrint("init BLEManagerProvider");
    FlutterBluePlus.scanResults.listen((event) {
      for (final result in event) {
        addScanResult(result);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    debugPrint("BLEManagerProvider dispose");
  }

  void stopScan() {
    FlutterBluePlus.stopScan();
    state = state.copyWith(isScanning: false);
  }

  void reconnect() {
    if (state.connectedDevice != null) return;
    debugPrint("reconnecting");
    state = state.copyWith(isReconnecting: true);
    FlutterBluePlus.startScan();
  }

  void startScan() async {
    debugPrint("start scan...");
    if (Platform.isAndroid) {
      FlutterBluePlus.turnOn();
    }
    FlutterBluePlus.startScan(withServices: []);

    state = state.copyWith(isScanning: true);
  }

  void startConnect(BluetoothDevice device) {
    device.connect();
    state = state.copyWith(connectedDevice: device, isOnline: true);
  }

  void initConnection() {
    if (state.connectedDevice == null) return;
    state.connectedDevice?.connectionState
        .listen((BluetoothConnectionState state) async {
      if (state == BluetoothConnectionState.disconnected) {
        // TODO:
        // 1. typically, start a periodic timer that tries to
        //    periodically reconnect, or just call connect() again right now
        // 2. you must always re-discover services after disconnection!
        // 3. you should cancel subscriptions to all characteristics you listened to
      }
    });
  }

  void addScanResult(ScanResult s) {
    if (s.device.localName.isEmpty) return;
    if (state.scanResults
        .any((element) => element.remoteId == s.device.remoteId)) {
      return;
    }
    if (!s.device.localName.startsWith(bleName)) return;

    // if we have connected device are set, we will stop scanning
    // and connect to that device
    if (s.device.remoteId.toString() == state.connectedDeviceId &&
        state.isReconnecting) {
      stopScan();
      state = state.copyWith(
        connectedDevice: s.device,
        isReconnecting: false,
        isOnline: true,
      );
      return;
    }
    state = state.copyWith(scanResults: [...state.scanResults, s.device]);
  }

  void setReconnectId(String id) {
    state = state.copyWith(connectedDeviceId: id);
  }

  void clearScanResult() {
    state = state.copyWith(scanResults: []);
  }

  void refreshScan() {
    // clearScanResult();
    startScan();
  }

  void connect() async {
    final conn = state.connectedDevice;
    if (conn == null) return;
    await conn.connect(
      timeout: const Duration(seconds: 5),
      autoConnect: false,
    );
  }

  void healthCheck() async {
    debugPrint("health check");
    final conn = state.connectedDevice;
    if (conn == null) {
      reconnect();
      return;
    }

    try {
      //

      await conn.connect(
        timeout: const Duration(seconds: 1),
        autoConnect: false,
      );

      setOnline();

      state = state.copyWith(isReconnecting: false);
    } catch (e) {
      setOffline();
      // state = state.copyWith(isReconnecting: false);
    }
  }

  void setOnline() {
    state = state.copyWith(isOnline: true);
  }

  void setOffline() {
    state = state.copyWith(isOnline: false);
  }

  forgot() async {
    await SharedPreferences.getInstance().then((value) {
      value.remove("id");
      state = state.copyWith(connectedDevice: null);
    });
  }

  Future<BluetoothCharacteristic?> _callCharacteristic(
      String serviceGuid, String characteristicGuid) async {
    final conn = state.connectedDevice;
    if (conn == null) return null;

    final connState = await conn.connectionState.first;
    if (connState != BluetoothConnectionState.connected) {
      await conn.connect();
      await conn.discoverServices();
    }

    if (conn.servicesList == null) {
      return null;
    }

    final service = conn.servicesList
        ?.where((element) => element.serviceUuid.toString() == serviceGuid)
        .first;
    if (service == null) return null;

    final c = service.characteristics
        .where((element) =>
            element.characteristicUuid.toString() == characteristicGuid)
        .first;
    return c;
  }

  void checkRTC() async {
    debugPrint("check RTC");

    final c =
        await _callCharacteristic(BLEServices.rtc, RTCService.getCurrentTime);

    if (c == null) return;

    try {
      final result = await c.read();
      // convert into string
      final str = String.fromCharCodes(result);
      debugPrint("RTC: $str");
    } catch (e) {
      debugPrint("RTC: $e");
    }

    // parse result to Time

    return;
  }

//
}
