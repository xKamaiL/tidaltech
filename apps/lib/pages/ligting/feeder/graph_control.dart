import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tidal_tech/providers/lighting.dart';
import 'package:tidal_tech/theme/colors.dart';
import 'package:niku/namespace.dart' as n;

class TimeScheduleControl extends HookConsumerWidget {
  const TimeScheduleControl({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final points = ref.watch(
      timePointsNotifier,
    );
    final selected = ref.watch(timePointEditingProvider);
    return n.Box(
      n.Row([
        n.Row([
          n.Button(
            n.Icon(Icons.add)..color = ThemeColors.foreground,
          )
            ..onPressed = () {
              ref.read(timePointsNotifier.notifier).addTimePoint();
            }
            ..color = ThemeColors.foreground
            ..rounded = 8
            ..p = 0
            ..m = 0
            ..bg = ThemeColors.white,
          n.Button(
            n.Icon(Icons.remove)
              ..color = selected != null
                  ? ThemeColors.danger
                  : ThemeColors.zinc.shade200.withOpacity(0),
          )
            ..onPressed = () {
              if (points.isEmpty) {
                return;
              }
              if (selected == null) {
                return;
              }
              // open confirmation dialog
              n.showNikuDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: const Text("Delete time schedule point?"),
                    content: const Text(
                        "Are you sure you want to delete this time?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          ref
                              .read(timePointsNotifier.notifier)
                              .delete(selected);
                          ref.read(timePointEditingProvider.notifier).remove();
                          Navigator.of(context).pop();
                        },
                        child: Text("Delete"),
                      ),
                    ],
                  );
                },
              );
            }
            ..color = selected == null
                ? ThemeColors.mutedForeground
                : ThemeColors.foreground
            ..rounded = 8
            ..p = 0
            ..m = 0
            ..bg = selected != null
                ? ThemeColors.white
                : ThemeColors.zinc.shade200.withOpacity(0),
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
