import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:tidal_tech/pages/ligting/spectrum_card.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 0),
            color: Colors.black.withOpacity(0.45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SpectrumCard(),
            ),
          ),
        ),
      ),
    );
  }
}
