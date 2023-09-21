import 'package:flutter/material.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/theme/colors.dart';

class FeederTimeHeader extends StatelessWidget {
  const FeederTimeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return n.Row(List.generate(
      7,
      (index) => n.Text("${(index * 4).toString().padLeft(1, '0')}:00")
        ..fontSize = 12
        ..color = ThemeColors.foreground,
    ))
      ..spaceBetween;
  }
}
