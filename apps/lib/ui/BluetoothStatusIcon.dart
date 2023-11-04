import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/providers/ble_manager.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tidal_tech/stores/icon_status.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isConnect =
        ref.watch(iconStatusProvider.select((value) => value.bluetooth));

    final manager = ref.watch(bleManagerProvider);

    final textColor = widget.isDark ? Colors.blueAccent : Colors.white;

    final stream = useStream(
      FlutterBluePlus.connectedDevices.isNotEmpty
          ? FlutterBluePlus.connectedDevices[0].connectionState
          : const Stream.empty(),
      initialData: null,
    );

    if (stream.data != null &&
        stream.data != BluetoothConnectionState.connected) {
      debugPrint("bluetooth disconnected");
      ref.read(iconStatusProvider.notifier).setBluetooth(false);
    }

    return InkWell(
      onTap: () async {
        if (!isConnect) {
          final manager = ref.read(bleManagerProvider.notifier);
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
          color: isConnect ? textColor : ThemeColors.danger,
          size: 24,
        ),
      ),
    );
  }
}
