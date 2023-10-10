import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tidal_tech/constants/ble_services_ids.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../providers/devices.dart';
import '../../styles/button.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../providers/ble_manager.dart';
import 'package:niku/namespace.dart' as n;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tidal_tech/theme/colors.dart';
import 'package:go_router/go_router.dart';

import '../../ui/snackbar.dart';

final _servicesUuids = <Guid>[];

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
    final connected = ref.read(connectDeviceProvider.notifier);
    final scanner = ref.read(scannerProvider.notifier);
    if (Platform.isAndroid) {
      FlutterBluePlus.turnOn();
    }

    FlutterBluePlus.scanResults.listen((List<ScanResult> results) async {
      for (ScanResult result in results) {
        scanner.addDevice(
          result.device,
          result.rssi,
        );
      }
      // FlutterBluePlus.stopScan();
    });
    FlutterBluePlus.adapterState.listen((state) async {
      if (state == BluetoothAdapterState.on) {
        FlutterBluePlus.startScan(
          withServices: _servicesUuids,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final devices = ref.watch(scannerProvider);
    final connected = ref.watch(connectDeviceProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: n.Text("Connect to TidalTech device")
          ..color = Colors.grey.shade900
          ..fontSize = 18.0
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
                    child: devices.isEmpty
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
                              Text("Found ${devices.length} devices"),
                              const SizedBox(
                                height: 80,
                              ),
                              n.Button("Can't find tidal tech devices".n)
                                ..onPressed = () async {
                                  FlutterBluePlus.startScan(
                                    withServices: [],
                                  );
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
    final devices = ref.watch(scannerProvider);
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        ref.read(scannerProvider.notifier).clearDevices();
        FlutterBluePlus.stopScan();
        FlutterBluePlus.startScan(
          withServices: [],
        );
        await Future.delayed(const Duration(seconds: 1));
        FlutterBluePlus.stopScan();
      },
      child: GridView.count(
        crossAxisCount: 1,
        controller: ScrollController(keepScrollOffset: false),
        shrinkWrap: true,
        crossAxisSpacing: 8,
        children: [
          for (final device in devices)
            DeviceItem(
              device: device,
            ),
          n.Text("Found ${devices.length} devices")
            ..center
            ..mt = 24
            ..color = ThemeColors.mutedForeground
        ],
      ),
    );
  }
}

class DeviceItem extends HookConsumerWidget {
  final ScannerDeviceItem device;

  const DeviceItem({Key? key, required this.device}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = useStream(
      device.device.connectionState,
      initialData: BluetoothConnectionState.disconnected,
    );

    final loading = useState(false);

    useEffect(() {
      if (status.connectionState == ConnectionState.active) {
        debugPrint("discover services ${device.device.remoteId}");
        device.device.discoverServices();
      }
      return () async {
        // debugPrint("disconnect to ${device.device.remoteId}");
        // await device.device.disconnect();
      };
    }, const []);
    //

    return n.Box(
      n.Column([
        n.Box(),
        n.NikuIcon(
          CupertinoIcons.lightbulb,
        )
          ..size = 80.0
          ..color = ThemeColors.primary,
        n.Column([
          n.Text(device.device.localName)
            ..fontSize = 24
            ..bold
            ..color = ThemeColors.foreground
            ..center,
          n.Text("Address: " + device.device.remoteId.toString())
            ..fontSize = 12
            ..my = 4
            ..color = ThemeColors.zinc.shade600
            ..center,
          const SizedBox(
            height: 24,
          ),
          n.Button("".n)
            ..icon = Icon(CupertinoIcons.play)
            ..apply = XButtonStyle.confirm(loading: loading.value, label: "Connect")
            ..width = double.infinity
            ..onPressed = () async {
              loading.value = true;
              await device.device.connect(autoConnect: true);
              await device.device.discoverServices();
              if (device.device.servicesList!.isEmpty) {
                await device.device.disconnect();
                showTopSnackBar(
                  Overlay.of(context),
                  const XSnackBar.error(
                    message:
                    "Good job, your release is successful. Have a nice day",
                  ),
                );
                loading.value = false;
                return;
              }
              var i = 0;
              for (final service in device.device.servicesList!) {
                print("found service ${service.uuid}");
                if (BLEServices.list().contains(service.uuid)) {
                  i++;
                }
              }
              if (i != 3) {
                await device.device.disconnect();
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
              ref.read(connectDeviceProvider.notifier).set(device.device);
              // save device to local storage
              SharedPreferences prefs = await SharedPreferences.getInstance();

              await prefs.setString("id", device.device.remoteId.toString());
              loading.value = false;
              showTopSnackBar(
                Overlay.of(context),
                const XSnackBar.success(
                  message:
                  "Connected to device successfully",
                ),
              );
              Future.delayed(const Duration(seconds: 1), () {
                context.go("/home");
              });
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
