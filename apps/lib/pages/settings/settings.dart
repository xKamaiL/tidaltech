import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tidal_tech/stores/stores.dart';
import 'package:tidal_tech/theme/colors.dart';
import 'package:niku/namespace.dart' as n;

class SettingsIndexPage extends HookConsumerWidget {
  const SettingsIndexPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: n.Text("Settings")
          ..color = Colors.grey.shade900
          ..fontSize = 18.0
          ..bold,
        elevation: 0,
        backgroundColor: ThemeColors.white,
        automaticallyImplyLeading: true,
        centerTitle: false,
        actionsIconTheme: IconThemeData(color: Colors.grey.shade900),
      ),
      backgroundColor: ThemeColors.muted,
      body: n.Column([
        // avatar
        //
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(100),
            ),
            child: n.Icon(Icons.person)
              ..color = Colors.white
              ..size = 50,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: n.Column([
              n.ListTile(
                title: n.Text("Account")
                  ..color = Colors.grey.shade900
                  ..fontSize = 16.0
                  ..bold,
                subtitle: n.Text("Manage your account")
                  ..color = Colors.grey.shade900
                  ..fontSize = 14.0,
                trailing: n.Icon(Icons.arrow_forward_ios_rounded)
                  ..color = Colors.grey.shade900,
                onTap: () {},
                tileColor: ThemeColors.white,
              )
            ]),
          ),
        ),

        n.ListTile(
          title: n.Text("Sign out")
            ..color = ThemeColors.danger
            ..fontSize = 16.0
            ..center
            ..bold,
          onTap: () {
            ref.read(userProvider.notifier).signOut();
            context.go("/sign-in");
          },
        )
      ])
        ..my = 16
        ..hFull
        ..gap = 16
        ..wFull
        ..between,
    );
  }
}
