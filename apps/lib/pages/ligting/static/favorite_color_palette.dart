import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:niku/namespace.dart' as n;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:tidal_tech/models/models.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tidal_tech/stores/static_led_mode.dart';

import '../../../theme/colors.dart';

class FavoriteColorPalette extends HookConsumerWidget {
  const FavoriteColorPalette({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: api.fetchScenes(ListSceneParam(
        query: [],
      )),
      builder: (BuildContext context,
          AsyncSnapshot<APIFormat<ListSceneResult>> snapshot) {
        if (snapshot.hasData) {
          return _buildSceneList(
            context,
            snapshot,
            ref,
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return const Center(child: CupertinoActivityIndicator());
      },
    );
  }

  _buildSceneList(BuildContext context,
      AsyncSnapshot<APIFormat<ListSceneResult>> snapshot, WidgetRef ref) {
    if (snapshot.data == null) {
      return const SizedBox(
        height: 380,
        child: Center(
          child: Text("Failed to load scenes"),
        ),
      );
    }
    if (!snapshot.data!.ok) {
      return const SizedBox(
        height: 380,
        child: Center(
          child: Text("Failed to load scenes"),
        ),
      );
    }
    return SizedBox(
      height: 380,
      child:
          ResponsiveGridList(desiredItemWidth: 150, minSpacing: 8, children: [
        for (final scene in snapshot.data!.result?.items ?? [])
          SceneCard(
            scene: scene,
            onTap: () {
              //
              ref.read(staticLEDColorProvider.notifier).setFromScene(scene);
            },
          )
      ]),
    );
  }
}

class SceneCard extends HookConsumerWidget {
  final SceneItem scene;
  final VoidCallback onTap;

  const SceneCard({
    super.key,
    required this.scene,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      color: ThemeColors.zinc.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      child: InkWell(
        enableFeedback: false,
        onTap: () => {
          //
          onTap()
        },
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: n.Row([
            Container(
              decoration: BoxDecoration(
                color: ThemeColors.zinc.shade200,
                borderRadius: BorderRadius.circular(1000),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: n.Icon(getSceneIcon(scene.icon))
                  ..color = ThemeColors.zinc.shade600
                  ..size = 24,
              ),
            ),
            n.Text(scene.name)
              ..color = ThemeColors.black
              ..ml = 8
              ..bold,
          ])
            ..p = 8
            ..gap = 4,
        ),
      ),
    );
  }

  IconData? getSceneIcon(String icon) {
    switch (icon) {
      case "cloudy":
        return Icons.wb_cloudy;
      case "sunrise":
        return CupertinoIcons.sunrise_fill;
      case "sunset":
        return CupertinoIcons.sunset_fill;
      case "rain":
        return Icons.water;
      case "moonlight":
        return Icons.nightlight_round;
      case "daylight":
        return Icons.wb_sunny;
      case "thunderstorm":
        return CupertinoIcons.cloud_rain;
      case "lightning":
        return Icons.flash_on;
      case "storm":
        return Icons.cloud_queue;
    }
    return Icons.question_mark_outlined;
  }
}
