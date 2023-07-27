import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tidal_tech/theme/colors.dart';
import 'package:niku/namespace.dart' as n;

class SettingsIndexPage extends HookConsumerWidget {
  const SettingsIndexPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: n.Text("Settings")
          ..color = Colors.grey.shade900
          ..fontSize = 18.0
          ..bold,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        centerTitle: false,
        actionsIconTheme: IconThemeData(color: Colors.grey.shade900),
      ),
      backgroundColor: Colors.transparent,
      body: Center(
        child: Text('Settings'),
      ),
    );
  }
}
