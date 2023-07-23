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
            image: ExactAssetImage("assets/hdlight.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          // blur image
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3), // brightness
          ),

          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: SafeArea(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
