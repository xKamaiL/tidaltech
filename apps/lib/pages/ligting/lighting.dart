import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/pages/ligting/spectrum_card.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:tidal_tech/pages/ligting/time_selection.dart';
import 'package:tidal_tech/stores/lighting.dart';
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

class ModeSelection extends HookConsumerWidget {
  const ModeSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode =
        ref.watch(lightingModeProvider);

    return Container(
        child: n.Row([
          Expanded(
            child: GestureDetector(
              child: SizedBox(
                height: 37,
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                    color: Colors.black
                        .withOpacity(mode == LightingMode.custom ? 0.4 : 0.2),
                  ),
                  child: Align(
                    child: n.Text("Custom")
                      ..textAlign = TextAlign.center
                      ..color = Colors.white,
                  ),
                ),
              ),
              onTap: () {
                ref
                    .read(lightingModeProvider.notifier)
                    .setMode(LightingMode.custom);
              },
            ),
          ),
      Expanded(
        child: GestureDetector(
          child: SizedBox(
            height: 37,
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                color: Colors.black
                    .withOpacity(mode == LightingMode.preset ? 0.4 : 0.2),
              ),
              child: Align(
                child: n.Text("Preset")
                  ..textAlign = TextAlign.center
                  ..color = Colors.white,
              ),
            ),
          ),
          onTap: () {
            ref
                .read(lightingModeProvider.notifier)
                .setMode(LightingMode.preset);
          },
        ),
      ),
    ])
          ..crossAxisAlignment = CrossAxisAlignment.center
          ..crossAxisAlignment = CrossAxisAlignment.center
          ..rounded = 16);
  }
}
