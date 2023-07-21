import 'package:flutter/material.dart';
import 'package:niku/namespace.dart' as n;

class XButtonStyle {
  static final confirm = n.Button.elevated("".n)
    ..fontSize = 20
    ..splash = Colors.indigo.withOpacity(0.1)
    ..bg = Colors.indigo
    ..px = 16
    ..py = 10
    ..fontWeight = FontWeight.w600
    ..color = Colors.white
    ..rounded = 8;
}
