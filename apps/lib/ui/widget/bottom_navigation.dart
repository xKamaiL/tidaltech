import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 8,
      // more aquarium colors ?
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Color(0xff6c757d),
      backgroundColor: Color(0xC81a1a1a),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.light_mode),
          label: 'Lighting',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.movie_creation),
          label: 'Scenes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Setting',
        ),
      ],
      onTap: onTabTapped,
    );
  }

  void onTabTapped(int index) {
    switch (index) {
      case 0:
        context.go("/home");
        break;
      case 1:
        context.go("/lighting");
        break;
      case 2:
        context.go("/scenes");
        break;
      case 3:
        context.go("/setting");
        break;
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(10.0);
}
