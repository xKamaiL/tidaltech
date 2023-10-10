import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/providers/ble_manager.dart';
import 'package:tidal_tech/theme/colors.dart';
import 'package:tidal_tech/ui/snackbar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../providers/devices.dart';

class BluetoothStatusIcon extends HookConsumerWidget {
  final isDark = false;

  const BluetoothStatusIcon({Key? key, isDark = false}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final device = ref.watch(connectDeviceProvider);
    reconnect() async {
      if (!device.firstLoad) return;
    }

    final isConnect = device.ble != null;
    final isScanning = device.isScanning;
    useEffect(() {
      reconnect();
      return null;
    }, const []);
    FlutterBluePlus.isScanning.listen((event) {
      final x = ref.read(connectDeviceProvider.notifier);
      if (event) {
        x.startScan();
      } else {
        x.stopScan();
      }
    });
    final textColor = isDark ? Colors.black : Colors.white;
    return n.Padding(
      top: 8,
      right: 8,
      bottom: 8,
      left: 8,
      child: GestureDetector(
        onTap: () async {
          if (device.isScanning) {
          } else {}
        },
        child: n.Icon(
          isConnect
              ? isScanning
                  ? Icons.bluetooth_searching
                  : Icons.bluetooth_disabled
              : Icons.bluetooth_connected,
          color: isConnect ? textColor : textColor.withOpacity(0.75),
          size: 24,
        ),
      ),
    );
  }
}
