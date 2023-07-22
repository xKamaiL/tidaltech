import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;

class LightingIndexPage extends HookConsumerWidget {
  const LightingIndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return n.Column([
      n.Text('Lighting')
        ..color = Colors.white
        ..h5
        ..fontWeight = FontWeight.w600
        ..textAlign = TextAlign.left,
    ])
      ..p = 16
      ..gap = 4
      ..wFull
      ..hFull
      ..crossStart;
  }
}
