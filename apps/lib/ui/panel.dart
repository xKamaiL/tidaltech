import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:niku/namespace.dart' as n;

class Panel extends StatelessWidget {
  final String? title;

  final IconData? icon;

  final Color? color;

  final Widget child;

  final void Function()? onPressed;

  const Panel({
    Key? key,
    required this.child,
    this.title,
    this.icon,
    this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      color: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 8,
            bottom: 8,
          ),
          child: onPressed != null
              ? GestureDetector(
                  onTap: onPressed,
                  child: renderChild(),
                )
              : renderChild(),
        ),
      ),
    );
  }

  Widget renderChild() {
    if (title != null && icon != null) {
      return n.Column([
        n.Row([
          n.Icon(icon)
            ..color = color ?? Colors.white.withOpacity(0.65)
            ..size = 14,
          n.Text(title)
            ..color = color ?? Colors.white.withOpacity(0.65)
            ..fontSize = 14
            ..textAlign = TextAlign.center
            ..bold
        ])
          ..mb = 4
          ..mainAxisAlignment = MainAxisAlignment.start
          ..crossAxisAlignment = CrossAxisAlignment.center
          ..gap = 4,
        child,
      ]);
    }

    return child;
  }
}
