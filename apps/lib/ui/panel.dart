import 'package:flutter/material.dart';

class Panel extends StatelessWidget {
  final String? title = null;
  final Icon? icon = null;
  final Color? color = null;



  final Widget child;

  const Panel({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      color: Colors.black.withOpacity(0.45),
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
