import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/providers/ble_manager.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tidal_tech/theme/colors.dart';
import 'package:tidal_tech/ui/snackbar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class BluetoothStatusIcon extends ConsumerStatefulWidget {
  final bool isDark;

  const BluetoothStatusIcon({Key? key, this.isDark = false}) : super(key: key);

  @override
  ConsumerState<BluetoothStatusIcon> createState() =>
      _BluetoothStatusIconState();
}

class _BluetoothStatusIconState extends ConsumerState<BluetoothStatusIcon> {
  _BluetoothStatusIconState() : super();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    // loop every
    timer =
        Timer.periodic(const Duration(seconds: 15), (Timer t) => healthCheck());
  }

  void healthCheck() {
    final conn = ref.read(bleManagerProvider.notifier);
    conn.healthCheck();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final manager = ref.read(bleManagerProvider.notifier);
    final device = ref.watch(bleManagerProvider);

    final ok = device.isOnline;
    final isConnect = device.isConnected;
    final isScanning = device.isScanning;

    final textColor = widget.isDark ? Colors.blueAccent : Colors.white;

    return n.Padding(
      top: 8,
      right: 8,
      bottom: 8,
      left: 8,
      child: GestureDetector(
        onTap: () async {
          if (!ok) {
            showTopSnackBar(
              Overlay.of(context),
              const XSnackBar.error(
                message:
                    "Cannot connect to device. Please check light indicator on device.",
              ),
            );
          }
          if (device.isReconnecting) return;
          manager.reconnect();
        },
        child: n.Icon(
          !isConnect
              ? isScanning
                  ? Icons.bluetooth_searching
                  : Icons.bluetooth_disabled
              : Icons.bluetooth_connected,
          color: isConnect
              ? textColor.withOpacity(ok ? 1 : 0.5)
              : ThemeColors.danger,
          size: 24,
        ),
      ),
    );
  }
}
