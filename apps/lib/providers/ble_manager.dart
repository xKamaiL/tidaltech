import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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

  final isScanning;

  final isReconnecting;

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
    if (!state.firstLoad) return;
    //
    // TODO: re-connect logic
  }

  void startScan() async {
    if (Platform.isAndroid) {
      FlutterBluePlus.turnOn();
    }
    FlutterBluePlus.startScan(withServices: []);

    state = state.copyWith(isScanning: true);
  }

  void connectTo(BluetoothDevice device) {
    state = state.copyWith(connectedDevice: device);
  }

  void addScanResult(ScanResult s) {
    if (s.device.localName.isEmpty) return;
    if (state.scanResults
        .any((element) => element.remoteId == s.device.remoteId)) {
      return;
    }
    if (!s.device.localName.startsWith(bleName)) return;

    state = state.copyWith(scanResults: [...state.scanResults, s.device]);
  }

  void clearScanResult() {
    state = state.copyWith(scanResults: []);
  }

  void refreshScan() {
    clearScanResult();
    startScan();
  }
}
