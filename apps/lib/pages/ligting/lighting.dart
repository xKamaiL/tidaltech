import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/pages/ligting/feeder/index.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:tidal_tech/pages/ligting/time_selection.dart';
import 'package:tidal_tech/stores/lighting.dart';
import 'package:tidal_tech/theme/colors.dart';
import 'package:tidal_tech/ui/panel.dart';

class LightingIndexPage extends HookConsumerWidget {
  const LightingIndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(lightingModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: n.Text("Lighting")
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
          child: n.Column([
            ModeSelection(),
            if (mode == LightingMode.feed) ...renderCustom(),
            if (mode == LightingMode.ambient) ...renderPreset(),
          ])
            ..gap = 8,
        ),
      ),
    );
  }

  // feeder mode
  List<Widget> renderCustom() {
    return [
      const FeederControl(),
    ];
  }

  // ambient mode
  List<Widget> renderPreset() {
    return [
      ListView.separated(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Panel(
            child: n.Column([
              n.Row([
                n.Text("Preset $index")..color = Colors.white,
                n.Icon(Icons.edit)..color = Colors.white,
              ])
                ..mainAxisAlignment = MainAxisAlignment.spaceBetween
                ..gap = 8,
              // description
              n.Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec euismod, nisl sed aliquam ultricies, nunc nisl ultricies nisl, sed aliquam nisl nisl sed.")
                ..color = Colors.white.withOpacity(0.8),
              n.Row([
                n.Button("Apply".n)
                  ..bg = Colors.blue
                  ..color = Colors.white,
              ])
                ..mainAxisAlignment = MainAxisAlignment.end,
            ])
              ..gap = 8,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 8,
          );
        },
        itemCount: 10,
      )
    ];
  }
}

class ModeSelection extends HookConsumerWidget {
  const ModeSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(lightingModeProvider);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ThemeColors.zinc.shade100,
      ),
      child: n.Row([
        Expanded(
          child: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 6.0, bottom: 6.0),
              child: SizedBox(
                height: 38,
                width: double.infinity,
                child: AnimatedContainer(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    color: Colors.white
                        .withOpacity(mode == LightingMode.feed ? 1 : 0),
                  ),
                  duration: const Duration(milliseconds: 250),
                  child: Align(
                    child: n.Row([
                      n.Icon(Icons.water)
                        ..color = mode == LightingMode.feed
                            ? ThemeColors.foreground
                            : ThemeColors.zinc.shade500
                        ..size = 14.0,
                      n.Text("Feed Mode")
                        ..fontWeight = FontWeight.w500
                        ..textAlign = TextAlign.center
                        ..color = mode == LightingMode.feed
                            ? ThemeColors.foreground
                            : ThemeColors.zinc.shade500
                    ])
                      ..mainAxisAlignment = MainAxisAlignment.center
                      ..gap = 4,
                  ),
                ),
              ),
            ),
            onTap: () {
              ref
                  .read(lightingModeProvider.notifier)
                  .setMode(LightingMode.feed);
            },
          ),
        ),
        Expanded(
          child: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 6.0, bottom: 6.0),
              child: SizedBox(
                height: 38,
                width: double.infinity,
                child: AnimatedContainer(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    color: Colors.white
                        .withOpacity(mode == LightingMode.ambient ? 1 : 0),
                  ),
                  duration: const Duration(milliseconds: 250),
                  child: Align(
                    child: n.Row([
                      n.Icon(Icons.color_lens_sharp)
                        ..color = mode == LightingMode.ambient
                            ? ThemeColors.foreground
                            : ThemeColors.zinc.shade500
                        ..size = 16.0,
                      n.Text("Ambient Mode")
                        ..textAlign = TextAlign.center
                        ..color = mode == LightingMode.ambient
                            ? ThemeColors.foreground
                            : ThemeColors.zinc.shade500
                    ])
                      ..mainAxisAlignment = MainAxisAlignment.center
                      ..gap = 4,
                  ),
                ),
              ),
            ),
            onTap: () {
              ref
                  .read(lightingModeProvider.notifier)
                  .setMode(LightingMode.ambient);
            },
          ),
        ),
      ])
        ..crossAxisAlignment = CrossAxisAlignment.center
        ..crossAxisAlignment = CrossAxisAlignment.center,
    );
  }
}
