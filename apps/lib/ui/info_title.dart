import 'package:flutter/material.dart';
import 'package:niku/namespace.dart' as n;

class InfoTitle extends StatelessWidget {
  final String title;

  const InfoTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return n.Text(title)
      ..fontSize = 24
      ..bold
      ..color = Colors.white
      ..textAlign = TextAlign.left
      ..wFull;
  }
}
