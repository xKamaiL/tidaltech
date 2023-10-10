import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tidal_tech/constants/ble_services_ids.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../stores/bottom_bar.dart';
import '../../styles/button.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../providers/ble_manager.dart';
import 'package:niku/namespace.dart' as n;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tidal_tech/theme/colors.dart';
import 'package:go_router/go_router.dart';

import '../../ui/snackbar.dart';

class ScanPage extends ConsumerStatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends ConsumerState<ScanPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    FlutterBluePlus.stopScan();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final manager = ref.read(bleManagerProvider.notifier);

    FlutterBluePlus.adapterState.listen((event) {
      if (event == BluetoothAdapterState.on) {
        manager.startScan();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final knownDevices =
        ref.watch(bleManagerProvider.select((value) => value.scanResults));

    return Scaffold(
      appBar: AppBar(
        title: n.Text("Connect to TidalTech device")
          ..color = ThemeColors.zinc.shade900
          ..bold,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      extendBody: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: knownDevices.isEmpty
                        ? Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircularProgressIndicator(
                                color: ThemeColors.primary,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text("Scanning for devices..."),
                              Text("Found ${knownDevices.length} devices"),
                              const SizedBox(
                                height: 80,
                              ),
                              n.Button("Can't find tidal tech devices".n)
                                ..onPressed = () async {
                                  ref
                                      .read(bleManagerProvider.notifier)
                                      .refreshScan();
                                },
                            ],
                          )
                        : const DevicesList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DevicesList extends HookConsumerWidget {
  const DevicesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    final knownDevices = ref.watch(bleManagerProvider).knownDevices;
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 2));
        ref.read(bleManagerProvider.notifier).refreshScan();
      },
      child: GridView.count(
        crossAxisCount: 1,
        controller: ScrollController(keepScrollOffset: false),
        shrinkWrap: true,
        crossAxisSpacing: 8,
        children: [
          for (final device in knownDevices)
            DeviceItem(
              device: device,
            ),
          n.Text("Found ${knownDevices.length} devices")
            ..center
            ..mt = 24
            ..color = ThemeColors.mutedForeground,
          n.Text("For the first time, please connect to your device")
            ..center
            ..mt = 8
            ..color = ThemeColors.mutedForeground,
        ],
      ),
    );
  }
}

class DeviceItem extends HookConsumerWidget {
  final BluetoothDevice device;

  const DeviceItem({Key? key, required this.device}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = useStream(
      device.connectionState,
      initialData: BluetoothConnectionState.disconnected,
    );

    final loading = useState(false);

    return n.Box(
      n.Column([
        n.Box(),
        n.NikuIcon(
          CupertinoIcons.wind,
        )
          ..size = 80.0
          ..color = ThemeColors.primary,
        n.Column([
          n.Text(device.localName)
            ..fontSize = 24
            ..bold
            ..color = ThemeColors.foreground
            ..center,
          n.Text("ID: ${device.remoteId}")
            ..fontSize = 12
            ..my = 4
            ..color = ThemeColors.zinc.shade600
            ..center,
          const SizedBox(
            height: 24,
          ),
          n.Button("".n)
            ..icon = Icon(CupertinoIcons.play)
            ..apply =
                XButtonStyle.confirm(loading: loading.value, label: "Connect")
            ..width = double.infinity
            ..onPressed = () async {
              try {
                loading.value = true;
                if ((await device.connectionState.first) ==
                    BluetoothConnectionState.connected) {
                  await device.disconnect();
                }

                await FlutterBluePlus.stopScan();

                await device
                    .connect(
                  timeout: const Duration(seconds: 5),
                )
                    .then((value) {
                  return device.discoverServices();
                });

                if (device.servicesList!.isEmpty) {
                  await device.disconnect();
                  showTopSnackBar(
                    Overlay.of(context),
                    const XSnackBar.error(
                      message:
                          "This device is not a TidalTech device, please try again with another device",
                    ),
                  );
                  loading.value = false;
                  return;
                }
                var i = 0;
                for (final service in device.servicesList!) {
                  print("found service ${service.uuid}");
                  if (BLEServices.list().contains(service.uuid)) {
                    i++;
                  }
                }
                if (i != 3) {
                  await device.disconnect();
                  showTopSnackBar(
                    Overlay.of(context),
                    const XSnackBar.error(
                      message:
                          "Invalid device, please try again with another device",
                    ),
                  );
                  loading.value = false;

                  return;
                }
                // set global device to use
                ref.read(bleManagerProvider.notifier).startConnect(device);

                // save device to local storage
                SharedPreferences prefs = await SharedPreferences.getInstance();

                await prefs.setString("id", device.remoteId.toString());
                loading.value = false;
                showTopSnackBar(
                  Overlay.of(context),
                  const XSnackBar.success(
                    message: "Connected to device successfully",
                  ),
                );

                Future.delayed(const Duration(seconds: 1), () {
                  ref.read(bottomBarProvider.notifier).setPosition(0);
                  context.go("/home");
                });
              } catch (e) {
                print(e);
                loading.value = false;
                showTopSnackBar(
                  Overlay.of(context),
                  XSnackBar.error(
                    message: e.toString(),
                  ),
                );
              }
            }
        ]),
      ])
        ..spaceBetween
        ..p = 16,
    )
      ..backgroundColor = ThemeColors.zinc.shade100
      ..rounded = 8
      ..p = 8;
  }
}
