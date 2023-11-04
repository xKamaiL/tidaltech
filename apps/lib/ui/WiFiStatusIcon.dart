import 'dart:async';

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
  Timer? timer;
  bool isFirst = true;

  Timer periodicTimer(Duration duration, void Function(Timer timer) callback,
      {bool onStart = false}) {
    var result = Timer.periodic(duration, callback);
    if (onStart) {
      print("onStart");
      isFirst = false;
      // Asynchronous "immediate" callback as event.
      Timer(Duration.zero, () {
        if (result.isActive) callback(result);
      });
    }
    return result;
  }

  Stream<int> getWifiStatusAsStream() {
    StreamController<int> controller = StreamController<int>();
    Timer timer = periodicTimer(const Duration(seconds: 30), (timer) async {
      final s = await ref.read(bleManagerProvider.notifier).getWifiStatus();
      controller.add(s);
    }, onStart: isFirst);

    controller
      ..onCancel = () {
        timer.cancel();
      }
      ..onPause = () {
        timer.cancel();
      }
      ..onResume = () {};
    return controller.stream;
  }

  @override
  Widget build(BuildContext context) {
    final stream = useStream(
      getWifiStatusAsStream(),
      initialData: false,
    );

    useEffect(() {
      print("did mount");

      return null;
    });

    final ok = stream.data == 1;

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
          ok ? Icons.wifi : Icons.wifi_off,
          color: ok ? Colors.blueAccent : ThemeColors.danger,
          size: 24,
        ),
      ),
    );
  }
}
