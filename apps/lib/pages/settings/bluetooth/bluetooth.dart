import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/stores/device.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../providers/ble_manager.dart';
import '../../../theme/colors.dart';
import '../../../ui/snackbar.dart';
import '../widgets/scaffold.dart';

class BluetoothSettingPage extends HookConsumerWidget {
  const BluetoothSettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bleManager = ref.watch(bleManagerProvider);

    return SettingScaffold(
      title: "Bluetooth Connection",
      back: true,
      children: n.Column([
        n.ListTile(
          title: n.Text(
              "Bluetooth is ${bleManager.isConnected ? "connected" : "disconnected"}")
            ..color = Colors.grey.shade900
            ..fontSize = 16.0
            ..bold,
          subtitle: n.Text("Device: ${bleManager.connectedDevice?.localName}")
            ..color = ThemeColors.zinc.shade900
            ..fontSize = 12.0,
          trailing: n.Icon(Icons.bluetooth_connected)..color = Colors.green,
          onTap: () {},
          tileColor: ThemeColors.white,
        ),
        n.ListTile(
          title: n.Text("Disconnect")
            ..color = Colors.grey.shade900
            ..fontSize = 16.0
            ..bold,
          subtitle: n.Text("Disconnect from current device")
            ..color = ThemeColors.zinc.shade900
            ..fontSize = 12.0,
          trailing: n.Icon(Icons.remove)..color = Colors.red,
          onTap: () async {
            final msg = await ref.read(deviceProvider.notifier).forgot();
            if (msg.isEmpty) {
              ref.read(bleManagerProvider.notifier).forgot();
              showTopSnackBar(
                Overlay.of(context),
                const XSnackBar.success(
                  message: "Remove device successfully",
                ),
              );
              await Future.delayed(Duration(seconds: 1), () {
                context.go("/scan");
              });
            } else {
              showTopSnackBar(
                Overlay.of(context),
                XSnackBar.error(
                  message: "Failed: $msg",
                ),
              );
            }
          },
        )..mt = 8 * 4,
      ])
        ..gap = 4
        ..p = 8,
    );
  }
}
