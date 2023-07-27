import 'package:flutter/material.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/theme/colors.dart';

class XButtonStyle {
  static danger({
    String label = "Delete",

    bool? loading = false,
    bool outline = false,

    Icon? icon,
  }) {
    return n.Button.elevated("".n)
      ..fontSize = 18
      ..splash = ThemeColors.danger.withOpacity(0.1)
      ..bg = ThemeColors.danger
      ..px = 0
      ..py = 16
      ..elevation = 0
      ..fontWeight = FontWeight.w600
      ..color = Colors.white
      ..icon = icon
      ..label = label.n
      ..rounded = 8;
  }

  static confirm({
    bool loading = false,
    String label = "Confirm",
    Icon? icon,
  }) {
    return n.Button.elevated("".n)
      ..fontSize = 18
      ..splash = ThemeColors.primary.withOpacity(0.1)
      ..bg =
          !loading ? ThemeColors.primary : ThemeColors.primary.withOpacity(0.5)
      ..px = 0
      ..py = 16
      ..elevation = 0
      ..fontWeight = FontWeight.w600
      ..color = Colors.white
      ..icon = loading
          ? Container(
              width: 16,
              height: 16,
              padding: const EdgeInsets.all(2.0),
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            )
          : icon
      ..label = label.n
      ..rounded = 8;
  }

  static final large = n.Button("".n);
}
