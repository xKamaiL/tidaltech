import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/providers/ble_manager.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tidal_tech/theme/colors.dart';

class BluetoothStatusIcon extends ConsumerStatefulWidget {
  final bool isDark;

  const BluetoothStatusIcon({Key? key, this.isDark = false}) : super(key: key);

  @override
  ConsumerState<BluetoothStatusIcon> createState() =>
      _BluetoothStatusIconState();
}

class _BluetoothStatusIconState extends ConsumerState<BluetoothStatusIcon> {
  _BluetoothStatusIconState() : super();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final manager = ref.read(bleManagerProvider.notifier);
    final device = ref.watch(bleManagerProvider);

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
          if (device.isReconnecting) return;
          manager.reconnect();
        },
        child: n.Icon(
          !isConnect
              ? isScanning
                  ? Icons.bluetooth_searching
                  : Icons.bluetooth_disabled
              : Icons.bluetooth_connected,
          color: isConnect ? textColor : ThemeColors.danger,
          size: 24,
        ),
      ),
    );
  }
}
