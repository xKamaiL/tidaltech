import 'package:flutter/material.dart';
import 'package:niku/namespace.dart' as n;

class XButtonStyle {
  static confirm({
    bool loading = false,
    String label = "Confirm",
    Icon? icon,
  }) {
    return n.Button.elevated("".n)
      ..fontSize = 20
      ..splash = Colors.indigo.withOpacity(0.1)
      ..bg = !loading ? Colors.indigo : Colors.indigo.withOpacity(0.5)
      ..px = 0
      ..py = 18
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
