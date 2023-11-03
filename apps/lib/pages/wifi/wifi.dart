import 'dart:io';

import 'package:esp_smartconfig/esp_smartconfig.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:niku/namespace.dart' as n;
import 'package:permission_handler/permission_handler.dart';
import 'package:tidal_tech/styles/button.dart';
import 'package:network_info_plus/network_info_plus.dart';

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

  @override
  Widget build(BuildContext context) {
    final provisioner = Provisioner.espTouch();

    provisioner.listen((response) {
      print("\n"
          "\n------------------------------------------------------------------------\n"
          "Device ($response) is connected to WiFi!"
          "\n------------------------------------------------------------------------\n");
    });

    final loading = useState(false);
    final name = useTextEditingController();
    final password = useTextEditingController();

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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: n.Column([
            n.Column([
              n.Box()..h = 36,
              n.TextFormField()
                ..controller = name
                ..isFilled
                ..scrollPhysics = const NeverScrollableScrollPhysics()
                ..scrollPadding = EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom - 16 * 4)
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
                    bottom: MediaQuery.of(context).viewInsets.bottom - 16 * 4)
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
                final info = NetworkInfo();
                final wifiName = await info.getWifiName();
                final wifiBSSID = await info.getWifiBSSID();
                print(wifiName);
                // --
                try {
                  await provisioner.start(ProvisioningRequest.fromStrings(
                    ssid: "xkamail",
                    bssid: wifiBSSID!,
                    password: "0931367693",
                  ));

                  await Future.delayed(Duration(seconds: 10));
                } catch (e, s) {
                  print(e);
                  print(s);
                }
                provisioner.stop();

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
        ),
      ),
    );
  }
}
