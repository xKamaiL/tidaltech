import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;

import '../../../theme/colors.dart';

class SettingScaffold extends HookConsumerWidget {
  final Widget children;
  final String? title;
  final bool back;

  const SettingScaffold(
      {super.key, required this.children, this.title, this.back = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: n.Text(title ?? "Settings")
          ..color = Colors.grey.shade900
          ..fontSize = 18.0
          ..bold,
        leading: back
            ? IconButton(
                icon: n.Icon(Icons.arrow_back_ios_rounded)
                  ..color = Colors.grey.shade900,
                onPressed: () {
                  context.pop();
                },
              )
            : null,
        elevation: 0,
        backgroundColor: ThemeColors.white,
        automaticallyImplyLeading: true,
        centerTitle: false,
        actionsIconTheme: IconThemeData(color: Colors.grey.shade900),
      ),
      backgroundColor: ThemeColors.muted,
      body: children,
    );
  }
}
