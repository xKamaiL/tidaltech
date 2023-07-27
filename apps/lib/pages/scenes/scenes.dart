import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:responsive_grid/responsive_grid.dart';
import 'package:tidal_tech/ui/panel.dart';

class ScenesIndexPage extends HookConsumerWidget {
  const ScenesIndexPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scenes'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
      ),
      backgroundColor: Colors.transparent,
      body: ResponsiveGridList(
        desiredItemWidth: 150,
        minSpacing: 8,
        children: [
          Panel(
            child: n.Row([
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: n.Icon(Icons.wb_sunny_outlined)
                    ..color = Colors.white
                    ..size = 24,
                ),
              ),
              n.Column([n.Text('Morning')..color = Colors.white])..py = 12
            ])
              ..gap = 12
              ..py = 4,
          ),
          Panel(
            title: "Cloudy",
            icon: Icons.cloud_outlined,
            child: n.Text('Afternoon')..color = Colors.white,
          ),
        ],
      ),
    );
  }
}
