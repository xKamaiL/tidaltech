import 'package:flutter/material.dart';

class InfoTitle extends StatelessWidget {
  final String title;

  const InfoTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title);
  }
}
