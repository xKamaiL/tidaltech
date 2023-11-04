import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/providers/ble_manager.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tidal_tech/theme/colors.dart';
import 'package:tidal_tech/ui/snackbar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class BluetoothStatusIcon extends StatefulHookConsumerWidget {
  final bool isDark;

  const BluetoothStatusIcon({super.key, this.isDark = false});

  @override
  ConsumerState<BluetoothStatusIcon> createState() =>
      _BluetoothStatusIconState();
}

class _BluetoothStatusIconState extends ConsumerState<BluetoothStatusIcon> {
  _BluetoothStatusIconState() : super();
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 10), (Timer t) {
      ref.read(bleManagerProvider.notifier).healthCheck();
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  emptyStream() {
    return Stream<BluetoothConnectionState>.periodic(
      const Duration(seconds: 5),
      (x) {
        return BluetoothConnectionState.disconnected;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final manager = ref.read(bleManagerProvider.notifier);

    final state = useStream<BluetoothConnectionState>(
      FlutterBluePlus.connectedDevices.isEmpty
          ? emptyStream()
          : FlutterBluePlus.connectedDevices[0].connectionState,
      initialData: BluetoothConnectionState.disconnected,
    );

    final ok = state.data == BluetoothConnectionState.connected;

    final isConnect = ok;

    final textColor = widget.isDark ? Colors.blueAccent : Colors.white;

    return InkWell(
      onTap: () async {
        if (!ok) {
          showTopSnackBar(
            Overlay.of(context),
            const XSnackBar.error(
              message:
                  "Cannot connect to device. Please check light indicator on device.",
            ),
          );
          manager.reconnect();
        }
      },
      child: n.Padding(
        top: 8,
        right: 16,
        bottom: 8,
        left: 16,
        child: n.Icon(
          !isConnect ? Icons.bluetooth_disabled : Icons.bluetooth_connected,
          color: isConnect
              ? textColor.withOpacity(ok ? 1 : 0.5)
              : ThemeColors.danger,
          size: 24,
        ),
      ),
    );
  }
}
