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
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        centerTitle: false,
        actionsIconTheme: IconThemeData(color: Colors.grey.shade900),
      ),
      backgroundColor: Colors.transparent,
      body: n.Column([
        // avatar
        //
        Container(
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
              )
            ]),
          ),
        ),

        n.ListTile(
          title: n.Text("Sign out")
            ..color = Colors.grey.shade900
            ..fontSize = 16.0
            ..bold,
          onTap: () {
            ref.read(userProvider.notifier).signOut();
            context.go("/sign-in");
          },
        )
      ])
        ..mb = 16
        ..hFull
        ..gap = 16
        ..wFull
        ..between,
    );
  }
}
