import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:responsive_grid/responsive_grid.dart';
import 'package:tidal_tech/ui/panel.dart';

class ScenesIndexPage extends HookConsumerWidget {
  const ScenesIndexPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: n.Text('Scenes and Effects')
          ..color = Colors.grey.shade900
          ..fontSize = 18.0
          ..bold,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        centerTitle: false,
        actionsIconTheme: IconThemeData(color: Colors.grey.shade900),
        actions: [
          n.IconButton(
            Icons.menu,
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      body: n.Column([]),
    );
  }
}
