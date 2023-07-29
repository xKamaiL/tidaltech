
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tidal_tech/pages/ligting/feeder/profile.dart';
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
            ..splash = ThemeColors.mutedForeground.withOpacity(0.1)
            ..bg = ThemeColors.white,
          if (selected != null)
            n.Button(
              n.Icon(Icons.remove)..color = ThemeColors.danger,
            )
              ..onPressed = () {
                if (points.isEmpty) {
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
                        CupertinoDialogAction(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          isDestructiveAction: true,
                          child: const Text('Cancel'),
                        ),
                        CupertinoDialogAction(
                          onPressed: () {
                            ref
                                .read(timePointsNotifier.notifier)
                                .delete(selected);
                            ref
                                .read(timePointEditingProvider.notifier)
                                .remove();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    );
                  },
                );
              }
              ..color = ThemeColors.mutedForeground
              ..rounded = 8
              ..p = 0
              ..m = 0
              ..splash = ThemeColors.mutedForeground.withOpacity(0.1)
              ..bg = ThemeColors.white,
        ])
          ..gap = 4,
        n.Row([
          if (selected != null)
            n.Button(
              n.Icon(Icons.play_arrow_outlined)..color = ThemeColors.foreground,
            )
              ..color = ThemeColors.foreground
              ..rounded = 8
              ..w = 60
              ..p = 0
              ..m = 0
              ..bg = ThemeColors.white,
          if (selected != null)
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
            ..onPressed = () {
              context.push('/lighting/feeder/profile');
            }
            ..color = ThemeColors.foreground
            ..rounded = 8
            ..w = 40
            ..p = 0
            ..m = 0
            ..splash = ThemeColors.mutedForeground.withOpacity(0.1)
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
