import 'package:TidalTech/stores/stores.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vrouter/vrouter.dart';

class LandingPage extends HookConsumerWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User? user = ref.watch(userProvider);
    String name = "no auth";
    if (user != null) {
      name = user.name;
    }

    return Scaffold(
      body: Center(
        child: Text("Landing Page hello $name"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (v) => {
           if (v == 0) {
             context.vRouter.to("/home")
           } else if (v == 1) {
             context.vRouter.to("/devices")
           } else if (v == 2) {
             context.vRouter.to("/profile")
           }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.laptop_mac),
            label: "Devices",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
