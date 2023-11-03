import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/pages/ligting/ambient/color_picker.dart';
import 'package:tidal_tech/pages/ligting/feeder/index.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:tidal_tech/stores/device.dart';
import 'package:tidal_tech/stores/lighting.dart';
import 'package:tidal_tech/theme/colors.dart';
import 'package:tidal_tech/ui/BluetoothStatusIcon.dart';
import 'package:tidal_tech/ui/WiFiStatusIcon.dart';

class LightingIndexPage extends HookConsumerWidget {
  const LightingIndexPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(lightingModeProvider);

    final tabController = useTabController(
        initialLength: 2, initialIndex: mode == LightingMode.feed ? 0 : 1);

    return Scaffold(
      appBar: AppBar(
        title: n.Text("Lighting")
          ..color = Colors.grey.shade900
          ..fontSize = 18.0
          ..bold,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: const [
          WiFiStatusIcon(
            isDark: true,
          ),
          BluetoothStatusIcon(
            isDark: true,
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
        child: n.Column([
          ModeSelection(tabController),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                SingleChildScrollView(
                  child: n.Column(renderCustom()),
                ),
                SingleChildScrollView(
                  child: n.Column(renderPreset()),
                ),
              ],
            ),
          )
        ])
          ..gap = 8,
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
      const ColorPicker(),
    ];
  }
}

class ModeSelection extends HookConsumerWidget {
  final TabController tabController;

  const ModeSelection(this.tabController, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(lightingModeProvider);

    // iterate
    ref.listen(lightingModeProvider, (_, next) {
      tabController.animateTo(LightingMode.ambient == next ? 1 : 0);
    });

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
                      n.Text("Schedule Mode")
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
              ref.read(deviceProvider.notifier).setMode(LightingMode.feed);
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
                      n.Text("Static Mode")
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
              ref.read(deviceProvider.notifier).setMode(LightingMode.ambient);
            },
          ),
        ),
      ])
        ..crossAxisAlignment = CrossAxisAlignment.center
        ..crossAxisAlignment = CrossAxisAlignment.center,
    );
  }
}
