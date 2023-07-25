import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tidal_tech/theme/colors.dart';
import 'package:niku/namespace.dart' as n;

class TimeScheduleControl extends HookConsumerWidget {
  const TimeScheduleControl({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return n.Box(
      n.Row([
        n.Row([
          n.Button(
            n.Icon(Icons.add)..color = ThemeColors.foreground,
          )
            ..color = ThemeColors.foreground
            ..rounded = 8
            ..p = 0
            ..m = 0
            ..bg = ThemeColors.white,
          n.Button(
            n.Icon(Icons.remove)..color = ThemeColors.foreground,
          )
            ..color = ThemeColors.foreground
            ..rounded = 8
            ..p = 0
            ..m = 0
            ..bg = ThemeColors.white,
        ])
          ..gap = 4,
        n.Row([
          n.Button(
            n.Icon(Icons.play_arrow_outlined)..color = ThemeColors.foreground,
          )
            ..color = ThemeColors.foreground
            ..rounded = 8
            ..w = 60
            ..p = 0
            ..m = 0
            ..bg = ThemeColors.white,
          n.Button(
            n.Icon(Icons.star_outline)..color = ThemeColors.foreground,
          )
            ..color = ThemeColors.foreground
            ..rounded = 8
            ..w = 40
            ..p = 0
            ..m = 0
            ..bg = ThemeColors.white,
          n.Button(
            n.Icon(Icons.menu)..color = ThemeColors.foreground,
          )
            ..color = ThemeColors.foreground
            ..rounded = 8
            ..w = 40
            ..p = 0
            ..m = 0
            ..bg = ThemeColors.white,
        ])
          ..gap = 4
      ])
        ..spaceBetween
        ..gap = 4,
    )
      ..px = 10
      ..bg = ThemeColors.zinc.shade100
      ..rounded = 8;
  }
}
