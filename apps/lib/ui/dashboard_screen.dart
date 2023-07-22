import 'dart:ui';

import 'package:tidal_tech/ui/widget/bottom_navigation.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  final Widget child;

  // background image
  final String? backgroundImage;

  const DashboardScreen({Key? key, required this.child, this.backgroundImage})
      : super(key: key);

  static const routeName = '/dashboard';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    // add background image
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('My Home'),
        actions: [
          IconButton(
            onPressed: () {
              //
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              //
            },
            icon: Icon(
              Icons.more_vert,
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
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
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              child: SafeArea(
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 56.0,
        child: BottomNavigationWidget(),
      ),
    );
  }
}
