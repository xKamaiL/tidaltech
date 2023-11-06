import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tidal_tech/constants/ble_services_ids.dart';
import 'package:tidal_tech/proto/message.pb.dart';
import 'package:tidal_tech/providers/feeder.dart';
import 'package:tidal_tech/stores/icon_status.dart';
import 'package:tidal_tech/stores/lighting.dart';

const String bleName = "TIDAL";

@immutable
class BLEManager extends Equatable {
  final bool firstLoad = true;

  final List<BluetoothDevice> scanResults;

  // store current paired device
  final BluetoothDevice? connectedDevice;
  final String connectedDeviceId;

  final bool isScanning;
  final bool isReconnecting;

  bool get isConnected => connectedDevice != null;

  get scanLength => scanResults.length;

  bool get isDisconnected => connectedDevice == null;

  List<BluetoothDevice> get knownDevices => scanResults;

  const BLEManager(
    this.scanResults,
    this.connectedDevice,
    this.connectedDeviceId,
    this.isScanning,
    this.isReconnecting,
  );

  BLEManager copyWith({
    List<BluetoothDevice>? scanResults,
    BluetoothDevice? connectedDevice,
    String? connectedDeviceId,
    bool? isScanning,
    bool? isReconnecting,
  }) {
    return BLEManager(
      scanResults ?? this.scanResults,
      connectedDevice ?? this.connectedDevice,
      connectedDeviceId ?? this.connectedDeviceId,
      isScanning ?? this.isScanning,
      isReconnecting ?? this.isReconnecting,
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
      ];
}

final bleManagerProvider =
    StateNotifierProvider<BLEManagerProvider, BLEManager>((ref) {
//
  return BLEManagerProvider(ref);
});

class BLEManagerProvider extends StateNotifier<BLEManager> {
  Ref ref;

  BLEManagerProvider(
    this.ref,
  ) : super(const BLEManager([], null, "", false, false));

  Future<void> stopScan() async {
    await FlutterBluePlus.stopScan();
    state = state.copyWith(isScanning: false);
  }

  void delayReconnect() {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      debugPrint("delay reconnect");
      reconnect();
    });
  }

  // reconnect
  // run when user click on bluetooth icon
  void reconnect() {
    if (state.isReconnecting) return;
    debugPrint("reconnect with ${state.connectedDeviceId}");
    state = state.copyWith(isReconnecting: true, scanResults: []);

    final alreadyConn = FlutterBluePlus.connectedDevices.where(
        (element) => element.remoteId.toString() == state.connectedDeviceId);
    if (alreadyConn.isNotEmpty) {
      state = state.copyWith(
        connectedDevice: alreadyConn.first,
        isReconnecting: false,
      );
      connect();
      return;
    }
    // start scan
    final s = FlutterBluePlus.scanResults.listen((event) {
      for (final result in event) {
        addScanResult(result);
      }
    });
    debugPrint("start reconnect...");
    startScan();

    Future.delayed(const Duration(seconds: 30)).then((value) {
      s.cancel();
      state = state.copyWith(isReconnecting: false);
      debugPrint("reconnect done");
    });
  }

  void startScan() async {
    if (Platform.isAndroid) {
      FlutterBluePlus.turnOn();
    }
    FlutterBluePlus.startScan(withServices: []);

    state = state.copyWith(isScanning: true);
  }

  void startConnect(BluetoothDevice device) async {
    await stopScan();
    device.connect();
    state = state.copyWith(connectedDevice: device);
  }

  void addScanResult(ScanResult s) async {
    if (s.device.platformName.isEmpty) return;
    // if we have connected device are set, we will stop scanning
    // and connect to that device
    if (s.device.remoteId.toString() == state.connectedDeviceId &&
        state.isReconnecting) {
      stopScan();
      state = state.copyWith(
        connectedDevice: s.device,
        isReconnecting: false,
      );
      connect();
      return;
    }
    if (state.scanResults
        .any((element) => element.remoteId == s.device.remoteId)) {
      return;
    }

    if (!s.device.platformName.startsWith(bleName)) {
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
    debugPrint(
        "BLEManagerProvider: connect to device ${conn.remoteId.toString()}");
    await conn.connect(
      timeout: const Duration(seconds: 5),
      autoConnect: false,
    );
    ref.read(iconStatusProvider.notifier).setBluetooth(true);
  }

  forgot() async {
    await SharedPreferences.getInstance().then((value) {
      value.remove("id");
      state = state.copyWith(connectedDevice: null);
    });
  }

  Future<BluetoothCharacteristic?> _callCharacteristic(
      String serviceGuid, String characteristicGuid,
      {bool reconnect = true}) async {
    final conn = state.connectedDevice;
    if (conn == null) {
      debugPrint("_callCharacteristic: conn is null");
      this.reconnect();
      return null;
    }
    await stopScan();

    final connState = await conn.connectionState.first;
    if (connState != BluetoothConnectionState.connected && reconnect) {
      debugPrint("_callCharacteristic: conn is not connected");
      await conn.connect();
      return _callCharacteristic(serviceGuid, characteristicGuid,
          reconnect: false);
    }
    await conn.discoverServices();

    if (conn.servicesList == null) {
      debugPrint("_callCharacteristic: services list is null");
      return null;
    }

    final service = conn.servicesList
        ?.where((element) => element.serviceUuid.toString() == serviceGuid)
        .first;
    if (service == null) {
      debugPrint("_callCharacteristic: service is null");
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

  void setStaticColor(Map<LED, ColorPoint> colors) async {
    final c = await _callCharacteristic(
        BLEServices.color, ColorService.setStaticColor);
    // send to device
    if (c == null) {
      return;
    }
    final req = SetStaticColorRequest();

    req.white = colors[LED.white]!.intensity;
    req.blue = colors[LED.blue]!.intensity;
    req.royalBlue = colors[LED.royalBlue]!.intensity;
    req.warmWhite = colors[LED.warmWhite]!.intensity;
    req.ultraViolet = colors[LED.ultraViolet]!.intensity;
    req.red = colors[LED.red]!.intensity;
    req.green = colors[LED.green]!.intensity;



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
