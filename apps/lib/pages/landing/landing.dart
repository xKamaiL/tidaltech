import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tidal_tech/providers/devices.dart';
import 'package:tidal_tech/theme/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:niku/namespace.dart' as n;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../providers/ble_manager.dart';
import '../../styles/button.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:collection/collection.dart';

// TODO: refactor later
final _servicesUuids = <Guid>[Guid("399d90e1-16f1-4fe9-8c2c-91058ed7ae4a")];

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reconnect().then((found) {
      if (found) return;
      debugPrint("start scan");
      final x = ref.read(scannerProvider.notifier);
      final connected = ref.read(connectDeviceProvider.notifier);

      FlutterBluePlus.scanResults.listen((List<ScanResult> results) async {
        // print("found ${results.length} devices");
        for (ScanResult result in results) {
          x.addDevice(
            result.device,
            result.rssi,
          );
        }
        FlutterBluePlus.stopScan();
      });
      FlutterBluePlus.adapterState.listen((state) async {
        // debugPrint("adapter state $state ${connected.isConnected()}");
        if (state == BluetoothAdapterState.on && !connected.isConnected()) {
          FlutterBluePlus.startScan(
            withServices: _servicesUuids,
          );
        }
      });
    });
  }

  Future<bool> reconnect() async {
    final connected = ref.read(connectDeviceProvider.notifier);
    final prefs = await SharedPreferences.getInstance();
    // try to find device from local storage
    final id = prefs.getString("id");
    if (id != null) {
      debugPrint("try to connect to $id");
      final connectedDevices = await FlutterBluePlus.connectedSystemDevices;
      debugPrint("found ${connectedDevices.length} devices");
      final device = (connectedDevices)
          .firstWhereOrNull((element) => element.remoteId.toString() == id);
      if (device != null) {
        // initial connection of bluetooth
        await device.connect();
        await device.discoverServices();
        // redirect to home
        connected.connect(device);
        FlutterBluePlus.stopScan();
        debugPrint("connected to $id successfully");
        return true;
      } else {
        debugPrint("%$id device not found");
      }
    }

    // FlutterBluePlus.connectedSystemDevices.then((device) async {
    //   final tidalDevices =
    //       device.where((element) => TidalDeviceFilter.ok(element));
    //   if (tidalDevices.isNotEmpty) {
    //     // initial connection of bluetooth
    //     await tidalDevices.first.connect();
    //     await tidalDevices.first.discoverServices();
    //     // redirect to home
    //     connected.connect(tidalDevices.first);
    //     context.go("/home");
    //     return true;
    //   }
    // });
    return false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    FlutterBluePlus.stopScan();
  }

  @override
  Widget build(BuildContext context) {
    final devices = ref.watch(scannerProvider);
    final connected = ref.watch(connectDeviceProvider.notifier);

    ref.listen(connectDeviceProvider.notifier, (previous, next) {
      if (next.isConnected()) {
        context.go("/home");
      }
    });

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
                                ..onPressed = () async {},
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
          withServices: _servicesUuids,
        );
        await Future.delayed(const Duration(seconds: 1));
        // FlutterBluePlus.stopScan();
      },
      child: GridView.count(
        crossAxisCount: 2,
        children: [
          for (final device in devices)
            DeviceItem(
              device: device,
            ),
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
    final waiting = status.connectionState == ConnectionState.waiting;
    final label = waiting
        ? "Connect"
        : waiting
            ? "Connecting..."
            : status.connectionState == ConnectionState.active
                ? "Connected"
                : "Connect";
    return Card(
      child: n.Column([
        n.Text(device.device.localName)
          ..fontSize = 18
          ..bold
          ..center,
        n.Text(device.device.remoteId.toString())
          ..fontSize = 12
          ..center,
        n.Button("Connect".n)
          ..apply = XButtonStyle.confirm(loading: false, label: "label")
          ..width = double.infinity
          ..onPressed = () async {
            await device.device.connect(autoConnect: true);
            await device.device.discoverServices();
            if (device.device.servicesList!.isEmpty) {
              // alert
              AlertDialog(
                title: const Text("Error"),
                content: const Text("Device not found"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK"),
                  )
                ],
              );
              return;
            }
            for (final service in device.device.servicesList!) {
              debugPrint("service ${service.uuid}");
              for (final characteristic in service.characteristics) {
                debugPrint("characteristic ${characteristic.uuid}");
              }
            }
            // set global device to use
            ref.read(connectDeviceProvider.notifier).connect(device.device);
            // save device to local storage
            SharedPreferences prefs = await SharedPreferences.getInstance();

            await prefs.setString("id", device.device.remoteId.toString());

            context.go("/home");
          }
      ])
        ..spaceBetween
        ..p = 8,
    );
  }
}
