import 'dart:async';

import 'package:esptouch_smartconfig/esptouch_smartconfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/styles/button.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../theme/colors.dart';

class WiFiSettingPages extends StatefulHookConsumerWidget {
  const WiFiSettingPages({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _WiFiSettingPagesState();
  }
}

class _WiFiSettingPagesState extends ConsumerState<WiFiSettingPages> {
  final _formKey = GlobalKey<FormState>();

  late Connectivity _connectivity;
  late Stream<ConnectivityResult> _connectivityStream;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ConnectivityResult? result;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _connectivity = Connectivity();
    _connectivityStream = _connectivity.onConnectivityChanged;
    _connectivitySubscription = _connectivityStream.listen((e) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    final name = useTextEditingController();
    final password = useTextEditingController();

    useEffect(() {
      //
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: n.Icon(Icons.arrow_back_ios_rounded)
            ..color = ThemeColors.foreground
            ..size = 18.0,
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
        ),
        title: n.Text('WiFi Connection')
          ..bold
          ..color = ThemeColors.foreground
          ..fontSize = 18.0,
        backgroundColor: ThemeColors.white,
        elevation: 1,
        centerTitle: true,
      ),
      backgroundColor: ThemeColors.zinc.shade100,
      body: FutureBuilder(
        future: _connectivity.checkConnectivity(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data != ConnectivityResult.wifi) {
            return const Center(
              child: Text('Please connect to WiFi'),
            );
          }

          return SingleChildScrollView(
            child: FutureBuilder<Map<String, String>?>(
              future: EsptouchSmartconfig.wifiData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Form(
                    key: _formKey,
                    child: n.Column([
                      n.Column([
                        n.Box()..h = 36,
                        n.TextFormField()
                          ..controller = name
                          ..isFilled
                          ..scrollPhysics = const NeverScrollableScrollPhysics()
                          ..scrollPadding = EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom -
                                  16 * 4)
                          ..maxLines = 1
                          ..rounded = 12
                          ..fontSize = 14
                          ..p = 16
                          ..noUnderline
                          ..bg = ThemeColors.white
                          ..color = ThemeColors.foreground
                          ..hintText = "WiFi Name"
                          ..textAlignVertical = TextAlignVertical.center
                          ..isCollapsed = true
                          ..textInputAction = TextInputAction.next
                          ..validator = (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter wifi name';
                            }
                            return null;
                          },
                        n.TextFormField()
                          ..controller = password
                          ..isFilled
                          ..scrollPhysics = const NeverScrollableScrollPhysics()
                          ..scrollPadding = EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom -
                                  16 * 4)
                          ..maxLines = 1
                          ..rounded = 12
                          ..fontSize = 14
                          ..p = 16
                          ..noUnderline
                          ..bg = ThemeColors.white
                          ..color = ThemeColors.foreground
                          ..hintText = "WiFi Password"
                          ..textAlignVertical = TextAlignVertical.center
                          ..isCollapsed = true
                          ..textInputAction = TextInputAction.go
                          ..onEditingComplete = () {
                            // hide keyboard
                            FocusManager.instance.primaryFocus?.unfocus();
                          }
                          ..validator = (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter wifi name';
                            }
                            return null;
                          },
                      ])
                        ..gap = 16,
                      n.Box()..h = 24,
                      n.Button(
                        'Connect to WiFi'.n,
                        onPressed: () async {
                          if (loading.value) return;
                          // Validate returns true if the form is valid, or false otherwise.

                          if (_formKey.currentState!.validate()) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          }
                          loading.value = true;
                          context.push(
                            "/wifi/broadcast/${name.text}/${password.text}",
                          );

                          loading.value = false;
                          //
                        },
                      )
                        ..apply = XButtonStyle.confirm(
                          loading: loading.value,
                          label: "Connect to WiFi",
                        )
                        ..fullWidth,
                    ])
                      ..mainAxisAlignment = MainAxisAlignment.center
                      ..crossAxisAlignment = CrossAxisAlignment.center
                      ..wFull
                      ..spaceBetween
                      ..py = 8
                      // ..bg = ThemeColors.danger
                      ..mt = 16
                      ..m = 8,
                  );
                } else {
                  return Container();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
