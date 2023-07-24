import 'package:flutter/material.dart';

class Panel extends StatelessWidget {
  final String? title;

  final Icon? icon;

  final Color? color;

  final Widget child;

  const Panel({
    Key? key,
    required this.child,
    this.title,
    this.icon,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      color: Colors.black.withOpacity(0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 8,
          bottom: 8,
        ),
        child: child,
      ),
    );
  }
}
