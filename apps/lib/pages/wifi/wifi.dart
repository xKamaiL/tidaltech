import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:niku/namespace.dart' as n;

class WiFiSettingPages extends StatefulHookConsumerWidget {
  const WiFiSettingPages({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _WiFiSettingPagesState();
  }
}

class _WiFiSettingPagesState extends ConsumerState<WiFiSettingPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: n.Text('WiFi Connection')
          ..bold
          ..fontSize = 18.0,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
