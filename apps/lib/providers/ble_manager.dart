import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tidal_tech/constants/ble_services_ids.dart';
import 'package:tidal_tech/proto/message.pb.dart';
import 'package:tidal_tech/providers/feeder.dart';
import 'package:tidal_tech/providers/lighting.dart';
import 'package:tidal_tech/stores/lighting.dart';

const String bleName = "TIDAL";

class TidalDeviceFilter {
  final String name;
  final String serviceUUID;

  TidalDeviceFilter(this.name, this.serviceUUID);

  static bool ok(BluetoothDevice device) {
    return device.platformName.startsWith(bleName);
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

  Future<void> stopScan() async {
    await FlutterBluePlus.stopScan();
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

  void startConnect(BluetoothDevice device) async {
    await stopScan();
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

  void addScanResult(ScanResult s) async {
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
    startScan();
    clearScanResult();
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
    final conn = state.connectedDevice;
    if (conn == null) {
      reconnect();
      return;
    }
    await stopScan();

    final s = await conn.connectionState.first;
    if (s == BluetoothConnectionState.connected) {
      setOnline();
      return;
    }
    try {
      //
      // FlutterBluePlus.setLogLevel(LogLevel.verbose);

      await conn.connect(
        timeout: const Duration(seconds: 15),
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
    if (conn == null) {
      debugPrint("conn is null");
      return null;
    }
    await stopScan();

    final connState = await conn.connectionState.first;
    if (connState != BluetoothConnectionState.connected) {
      debugPrint("conn is not connected");
      await conn.connect();
    }
    await conn.discoverServices();

    if (conn.servicesList == null) {
      debugPrint("services list is null");
      return null;
    }

    final service = conn.servicesList
        ?.where((element) => element.serviceUuid.toString() == serviceGuid)
        .first;
    if (service == null) {
      debugPrint("service is null");
      return null;
    }

    try {
      final c = service.characteristics
          .where((element) =>
              element.characteristicUuid.toString() == characteristicGuid)
          .first;
      return c;
    } catch (e) {
      return null;
    }
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

  void sendTimePoints({
    required List<TimePoint> timePoints,
  }) async {
    final c =
        await _callCharacteristic(BLEServices.color, ColorService.addTimePoint);
    // send to device
    if (c == null) {
      return;
    }
    for (final p in timePoints) {
      // log bytes length
      final req = p.toProto();
      final bytes = req.writeToBuffer();
      // print value
      c.write(
        bytes,
        withoutResponse: true,
      );
    }

    await Future.delayed(const Duration(milliseconds: 100)).then((value) async {
      final c = await _callCharacteristic(
          BLEServices.color, ColorService.listTimePoint);
      // send to device
      if (c == null) {
        return;
      }

      final req = ListTimePointRequest();
      for (final p in timePoints) {
        final t = ListTimePointRequest_Time();
        t.hh = p.hour;
        t.mm = p.minute;
        req.times.add(t);
      }
      // print value
      c.write(req.writeToBuffer(), withoutResponse: true);
    });
  }

  void setLightMode(LightingMode mode) async {
    final c =
        await _callCharacteristic(BLEServices.color, ColorService.setLightMode);
    // send to device
    if (c == null) {
      return;
    }
    final req = SetColorModeRequest();
    req.mode =
        mode == LightingMode.ambient ? Mode.MODE_MANUAL : Mode.MODE_SCHEDULE;
    // print value
    c.write(req.writeToBuffer(), withoutResponse: true);

    //
  }

  void setStaticColor(int rgb) async {
    final c = await _callCharacteristic(
        BLEServices.color, ColorService.setStaticColor);
    // send to device
    if (c == null) {
      return;
    }
    final req = SetAmbientRequest();

    req.r = (rgb >> 16) & 0xFF;
    req.g = (rgb >> 8) & 0xFF;
    req.b = rgb & 0xFF;
    // print value
    c.write(req.writeToBuffer(), withoutResponse: true);
  }

  Future<String> getWifiIP() async {
    final c = await _callCharacteristic(
        BLEServices.deviceInformation, DeviceInformationService.getWifiIP);
    // send to device
    if (c == null) {
      return "";
    }
    final result = await c.read();
    // convert into string
    final str = String.fromCharCodes(result);
    return str;
  }

  Future disconnectWifi() async {
    final c = await _callCharacteristic(
        BLEServices.deviceInformation, DeviceInformationService.disconnectWifi);
    // send to device
    if (c == null) {
      return;
    }
    await c.write([0], withoutResponse: true);
  }

  Future<int> getWifiStatus() async {
    final c = await _callCharacteristic(
        BLEServices.deviceInformation, DeviceInformationService.getWifiStatus);
    // send to device
    if (c == null) {
      return 0;
    }
    final result = await c.read();
    // convert into string
    if (result.isEmpty) {
      return 0;
    }
    if (result[0] == 0) {
      return 0;
    }
    return 1;
  }

  Future<String> getWifiSSID() async {
    final c = await _callCharacteristic(
        BLEServices.deviceInformation, DeviceInformationService.getWifiSSID);
    // send to device
    if (c == null) {
      return "";
    }
    final result = await c.read();
    // convert into string
    final str = String.fromCharCodes(result);
    return str;
  }

//
}
