import 'dart:ui';

import 'package:permission_handler/permission_handler.dart';
import 'package:tidal_tech/ui/widget/bottom_navigation.dart';
import 'package:flutter/material.dart';

class NormalScreen extends StatefulWidget {
  final Widget child;

  // background image
  final String? backgroundImage;

  const NormalScreen({super.key, required this.child, this.backgroundImage});

  @override
  State<NormalScreen> createState() => _NormalScreenState();
}

class _NormalScreenState extends State<NormalScreen> {
  static const blur = 5.0;

  // final flutterReactiveBle = FlutterReactiveBle();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // add background image
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          image: widget.backgroundImage != null
              ? DecorationImage(
                  // load assets from network
                  image: ExactAssetImage("assets/${widget.backgroundImage}"),
                  fit: BoxFit.fill,
                )
              : null,
        ),
        child: Container(
          // blur image
          decoration: widget.backgroundImage != null
              ? BoxDecoration(
                  color: Colors.black.withOpacity(0), // brightness
                )
              : null,

          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: SafeArea(
              child: widget.child,
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
