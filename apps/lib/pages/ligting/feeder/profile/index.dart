import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/models/api.dart';
import 'package:tidal_tech/models/models.dart';
import 'package:tidal_tech/providers/lighting.dart';
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
        child: FutureBuilder(
          future: api.fetchMyPresets(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              final res = snapshot.data as APIFormat<MyPresetResult>;
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
              return SingleChildScrollView(
                child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    children: [
                      for (var item in res.result!.items)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Dismissible(
                            key: UniqueKey(),
                            background: Container(color: Colors.red),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              print("remove ${item.id}");
                            },
                            confirmDismiss: (DismissDirection direction) async {
                              print(item.isPublic);
                              if (item.isPublic) {
                                return false;
                              }
                              final res = await api
                                  .deletePreset(DeletePresetParam(id: item.id));
                              return true;
                            },
                            child: n.ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              tileColor: ThemeColors.zinc.shade100,
                              title: n.Text(item.name)
                                ..fontWeight = FontWeight.w600
                                ..color = ThemeColors.foreground,
                              subtitle: n.Text(item.description.isEmpty
                                  ? "-"
                                  : item.description)
                                ..color = ThemeColors.zinc,
                              trailing: IconButton(
                                icon: n.Icon(Icons.more_vert)
                                  ..color = ThemeColors.foreground
                                  ..size = 18.0,
                                onPressed: () {},
                              ),
                              onTap: () {
                                if (item.timePoints == null) {
                                  return;
                                }
                                ref
                                    .read(timePointsNotifier.notifier)
                                    .initTimePoint(item.timePoints!);

                                if (context.canPop()) {
                                  context.pop();
                                }
                              },
                            ),
                          ),
                        )
                    ]),
              );
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
    );
  }

  loadList() {
    return api.fetchMyPresets();
  }
}
