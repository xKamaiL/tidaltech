import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tidal_tech/theme/colors.dart';
import 'package:go_router/go_router.dart';

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
    FlutterBluePlus.connectedSystemDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        // _addDeviceTolist(device);
        debugPrint("device: ${device.name}");
      }
    });
    FlutterBluePlus.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        // _addDeviceTolist(result.device);
        debugPrint("result: ${result.device.name}");
      }
    });
    FlutterBluePlus.startScan();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: ThemeColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
