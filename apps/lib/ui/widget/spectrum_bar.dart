import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/providers/feeder.dart';
import 'package:tidal_tech/theme/colors.dart';

final ledLabel = {
  LED.red: "Red",
  LED.green: "Green",
  LED.blue: "Blue",
  LED.white: "White",
  LED.ultraViolet: "UV",
  LED.royalBlue: "Royal",
  LED.warmWhite: "Warm",
};

class Bar extends HookConsumerWidget {
  final LED color;
  final int value;
  final ValueChanged<dynamic>? onChange;

  const Bar(this.color, this.value, this.onChange, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popup = useState(false);
    final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();
    String label = ledLabel[color] ?? "-";
    return Expanded(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: n.Text("$value%")
              ..color = ThemeColors.zinc.shade600
              ..fontWeight = FontWeight.w900
              ..ml = 8
              ..fontSize = 14,
          ),
          Align(
            alignment: Alignment.topRight,
            child: n.Text(label)
              ..color = ThemeColors.zinc.shade400
              ..fontWeight = FontWeight.w900
              ..fontSize = 10,
          ),
          SizedBox(
            width: double.infinity,
            child: CupertinoSlider(
              value: value.toDouble(),
              onChanged: (double value) {
                tooltipkey.currentState?.ensureTooltipVisible();
                popup.value = true;
                // setTimeout to hide popup
                Future.delayed(const Duration(milliseconds: 500), () {
                  popup.value = false;
                });
                onChange!(value);
              },
              max: 100,
              min: 0,
              activeColor: ledColor[color],
              thumbColor: ledColor[color]!,
            ),
          ),
        ],
      ),
    );

    // random value
  }
}
