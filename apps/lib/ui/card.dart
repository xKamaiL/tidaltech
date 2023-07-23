import 'package:flutter/material.dart';
import 'package:niku/namespace.dart' as n;

class Card extends StatelessWidget {
  final Widget child;

  const Card({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.45),
          borderRadius: BorderRadius.circular(16),
        ),
        child: AspectRatio(
          aspectRatio: 1,
          child: child,
        ),
      ),
    ));
  }
}
