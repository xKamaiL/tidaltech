import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:niku/namespace.dart' as n;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../theme/colors.dart';

class FavoriteColorPalette extends HookConsumerWidget {
  const FavoriteColorPalette({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = [
      {},
      {},
      {},
      {},
    ];

    return SizedBox(
      height: 300,
      width: double.infinity,
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        scrollDirection: Axis.horizontal,
        children: [
          SceneItem(),
          SceneItem(),
          SceneItem(),
          SceneItem(),
          SceneItem(),
        ],
      ),
    );
  }
}

class SceneItem extends HookConsumerWidget {
  const SceneItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return n.Row([
      n.Column([
        n.Icon(CupertinoIcons.sun_dust_fill)
          ..color = ThemeColors.zinc
          ..size = 40,
        n.Box()..h = 10,
        n.Text('Sunlight')..fontSize = 16,
      ])
        ..spaceBetween
        ..mainAxisAlignment = MainAxisAlignment.center
        ..gap = 4,
    ])
      ..bg = ThemeColors.zinc.shade100
      ..wFull
      ..rounded = 8
      ..crossAxisAlignment = CrossAxisAlignment.center
      ..mainAxisAlignment = MainAxisAlignment.center;
  }
}
