import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnBoardScreen extends StatelessWidget {
  final Widget child;

  const OnBoardScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            // load assets from network
            image: ExactAssetImage("assets/hdlight.jpeg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          // blur image
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0), // brightness
          ),

          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: SafeArea(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
