import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/pages/ligting/spectrum_card.dart';

import 'package:tidal_tech/pages/ligting/time_selection.dart';
import 'package:tidal_tech/ui/panel.dart';

class LightingIndexPage extends HookConsumerWidget {
  const LightingIndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lighting'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        centerTitle: false,
        actions: [
          n.IconButton(
            Icons.add,
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
          child: n.Column([
            ModeSelection(),
            Panel(child: SpectrumCard()),
            Panel(child: TimeSelection()),
            Panel(child: TimeSelection()),
          ])
            ..gap = 8,
        ),
      ),
    );
  }
}

class ModeSelection extends StatelessWidget {
  const ModeSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          color: Colors.white.withOpacity(0.3),
        ),
        child: n.Row([
          Expanded(
            flex: 50,
            child: n.Box(n.Text("Custom")..textAlign = TextAlign.center)
              ..borderRadius = BorderRadius.circular(16.0)
              ..bg = Colors.white.withOpacity(0.9),
          ),
          Expanded(
            flex: 50,
            child: GestureDetector(
              child: n.Box(n.Text("Profile")..textAlign = TextAlign.center)
                ..borderRadius = BorderRadius.circular(16.0)
                ..bg = Colors.white.withOpacity(0.5),
              onTap: () {},
            ),
          ),
        ])
          ..mx = 8
          ..crossAxisAlignment = CrossAxisAlignment.center
          ..crossAxisAlignment = CrossAxisAlignment.center
          ..rounded = 16);
  }
}
