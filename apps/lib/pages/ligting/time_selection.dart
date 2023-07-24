import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:flutter_hooks/flutter_hooks.dart';

class TimeSelection extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return n.Column([
      n.Padding(
        child: n.Text("Intensity Days")
          ..fontSize = 24
          ..bold
          ..color = Colors.white,
      )..p = 8,
      SizedBox(
        height: 180,
        child: n.ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              24,
              (index) => Container(
                  width: 50,
                  color: Colors.black12,
                  margin: const EdgeInsets.only(right: 6),
                  child: IntensitySelector(h: index.toString() + ":00")),
            )),
      ),
      n.Box()..height = 16
    ]);
  }
}

class IntensitySelector extends HookConsumerWidget {
  final String h;

  const IntensitySelector({super.key, required this.h});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intensity = useState(0);
    return (Center(
      child: n.Column([
        n.Text(h)
          ..fontSize = 12
          ..bold
          ..mt = 8
          ..color = Colors.white,
        n.Text("${intensity.value}%")
          ..fontSize = 12
          ..color = Colors.lightBlueAccent,
      ])
        ..py = 4
        ..spaceBetween,
    ));
  }
}
