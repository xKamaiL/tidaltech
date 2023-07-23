import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;

class LightingIndexPage extends HookConsumerWidget {
  const LightingIndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lighting'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        centerTitle: false,
        actions: [
          n.IconButton(
            Icons.add,
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      body: n.Column([
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
          width: double.infinity,
          child: Card(
            color: Colors.black.withOpacity(0.45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                n.Icon(Icons.ac_unit)
                  ..color = Colors.cyan.shade600
                  ..size = 48,
                n.Text('Hello ทดสอบ')
                  ..fontSize = 24
                  ..color = Colors.white
                  ..fontWeight = FontWeight.bold,
              ],
            ),
          ),
        )
      ])
        ..p = 16
        ..gap = 4
        ..wFull
        ..hFull
        ..crossStart,
    );
  }
}
