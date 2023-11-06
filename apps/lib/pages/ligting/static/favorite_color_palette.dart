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
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ThemeColors.zinc.shade100),
      child: n.Row([
        for (var i = 0; i < colors.length; i++)
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 50,
                color: Colors.red,
                child: const Center(
                  child: Icon(Icons.check, color: Colors.white),
                ),
              ),
            ),
          ),
      ])
        ..h = MediaQuery.of(context).size.height / 2.5,
    );
  }
}
