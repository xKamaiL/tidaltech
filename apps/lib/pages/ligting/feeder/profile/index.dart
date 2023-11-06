import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/models/api.dart';
import 'package:tidal_tech/models/models.dart';
import 'package:tidal_tech/theme/colors.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LightingFeederProfilePage extends HookConsumerWidget {
  const LightingFeederProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: n.Icon(Icons.arrow_back_ios_rounded)
            ..color = ThemeColors.foreground
            ..size = 18.0,
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
        ),
        title: n.Text("Schedule Profile")
          ..color = ThemeColors.foreground
          ..fontSize = 18.0
          ..bold,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: loadList(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return buildList(snapshot.data);
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
    return api.fetchMyPresets();
  }

  Widget buildList(
    APIFormat<MyPresetResult> res,
  ) {
    if (!res.ok) {
      return const SizedBox(
        height: 400,
        child: Center(
          child: Text("Error"),
        ),
      );
    }
    if (res.result == null) {
      return const SizedBox(
        height: 400,
        child: Center(
          child: Text("No data"),
        ),
      );
    }

    return n.Box(
      n.Text("Hello ${res.result?.items}"),
    );
  }
}
