import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:niku/namespace.dart' as n;

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tidal_tech/providers/ble_manager.dart';
import 'package:tidal_tech/theme/colors.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tidal_tech/ui/snackbar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class WiFiStatusIcon extends StatefulHookConsumerWidget {
  final bool isDark;

  const WiFiStatusIcon({super.key, this.isDark = false});

  @override
  ConsumerState<WiFiStatusIcon> createState() => _WiFiStatusIconState();
}

class _WiFiStatusIconState extends ConsumerState<WiFiStatusIcon> {
  @override
  Widget build(BuildContext context) {
    final status =
        useFuture(ref.read(bleManagerProvider.notifier).getWifiStatus());
    status.connectionState == ConnectionState.active ||
        status.connectionState == ConnectionState.waiting;
    useEffect(() {
      return null;
    }, []);

    return InkWell(
      onTap: () async {
        context.push("/wifi-settings");
      },
      child: n.Padding(
        top: 8,
        right: 16,
        bottom: 8,
        left: 16,
        child: n.Icon(
          status.data == 1 ? Icons.wifi : Icons.wifi_off,
          color: status.data == 1 ? Colors.blueAccent : Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
