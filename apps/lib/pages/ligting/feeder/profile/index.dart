import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/theme/colors.dart';

class LightingFeederProfilePage extends HookConsumerWidget {
  const LightingFeederProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: n.Text("Color Profile")
          ..color = Colors.grey.shade900
          ..fontSize = 18.0
          ..bold,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: n.IconButton(
          Icons.arrow_back_ios,
          onPressed: () {
            context.pop(true);
          },
        )
          ..splashColor = Colors.transparent
          ..p = 0
          ..m = 0
          ..color = ThemeColors.foreground,
        actionsIconTheme: const IconThemeData(color: ThemeColors.foreground),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: loadList(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return buildList();
              } else {
                return const SizedBox(
                  height: 400,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: ThemeColors.mutedForeground,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  loadList() {
    return Future.delayed(Duration(seconds: 3), () => "Loaded");
  }

  Widget buildList() {
    return n.Box(
      n.Text("Hello"),

    );
  }
}
