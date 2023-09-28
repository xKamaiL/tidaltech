import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tidal_tech/theme/colors.dart';
import 'package:go_router/go_router.dart';

import '../../providers/ble_manager.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final x = ref.read(scannerProvider.notifier);
    FlutterBluePlus.connectedSystemDevices.then((device) {
      for (final d in device) {
        debugPrint('Device found1: ${d.name} ${d.remoteId}');
        x.addDevice(
          d,
          0,
        );
      }
    });

    FlutterBluePlus.scanResults.listen((List<ScanResult> results) async {
      for (ScanResult result in results) {
        debugPrint(
            'Device found2: ${result.device.name} ${result.device.remoteId} ${result.rssi}');

        x.addDevice(
          result.device,
          result.rssi,
        );
      }
    });
    // check ble is on or not ?
    FlutterBluePlus.adapterState.listen((state) async {
      if (state == BluetoothAdapterState.on) {
        FlutterBluePlus.startScan(
          withServices: [],
        );
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    FlutterBluePlus.stopScan();
  }

  @override
  Widget build(BuildContext context) {
    final devices = ref.watch(scannerProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: devices.isEmpty
                ? [
                    const CircularProgressIndicator(
                      color: ThemeColors.primary,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Scanning for devices..."),
                    Text("Found ${devices.length} devices"),
                  ]
                : [
                    Container(),
                    ListView.builder(
                      itemCount: devices.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(
                              devices[index].device.localName ?? "Unknown"),
                          subtitle: Text(devices[index].device.remoteId.str),
                          trailing: Text(devices[index].rssi.toString()),
                        );
                      },
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}
