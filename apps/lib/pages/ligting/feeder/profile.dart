import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/theme/colors.dart';

class ColorProfile extends HookConsumerWidget {
  const ColorProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: n.Column([
        n.Text("Color Profile")
          ..fontSize = 24
          ..bold
          ..color = ThemeColors.foreground,
        n.Column([
          n.Box(
            n.Text("Color Profile")
              ..fontSize = 24
              ..color = ThemeColors.foreground,
          )
            ..rounded = 16
            ..p = 16
            ..wFull
            ..bg = ThemeColors.zinc.shade100
        ])
          ..wFull
          ..gap = 4,
      ])
        ..wFull
        ..p = 16
        ..gap = 4,
    );
  }
}
