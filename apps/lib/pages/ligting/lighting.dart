import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/pages/ligting/ambient/color_picker.dart';
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

    final tabController = useTabController(
        initialLength: 2, initialIndex: mode == LightingMode.feed ? 0 : 1);

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
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
        child: n.Column([
          ModeSelection(tabController),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
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
      ColorPicker(),
    ];
  }
}

class ModeSelection extends HookConsumerWidget {
  final TabController tabController;

  const ModeSelection(this.tabController, {Key? key}) : super(key: key);

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
              tabController.animateTo(0);
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
              tabController.animateTo(1);
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
