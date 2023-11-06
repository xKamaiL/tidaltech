import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:niku/namespace.dart' as n;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../theme/colors.dart';

class FavoriteColorPalette extends HookConsumerWidget {
  const FavoriteColorPalette({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = [
      {},
      {},
      {},
      {},
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ThemeColors.zinc.shade100),
      child: SizedBox(
        height: 250,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            margin: EdgeInsets.only(top: 8, bottom: 8),
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: false,
              children: [
                n.Box()
                  ..w = 40
                  ..h = 40
                  ..bg = Colors.red
                  ..rounded
                  ..pr = 8,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
