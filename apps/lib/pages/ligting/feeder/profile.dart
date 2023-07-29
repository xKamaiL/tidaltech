import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;

class ColorProfile extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 500,
      child: Column(
        children: [
          n.Text("Color Profile"),
          n.Row([
            n.Text("Color Profile"),
            n.Text("Color Profile"),
            n.Text("Color Profile"),
          ]),
        ],
      ),
    );
  }
}
