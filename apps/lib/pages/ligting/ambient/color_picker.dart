import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:niku/namespace.dart' as n;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tidal_tech/providers/ble_manager.dart';
import 'package:tidal_tech/stores/device.dart';
import 'package:tidal_tech/theme/colors.dart';

class ColorPicker extends StatefulHookConsumerWidget {
  const ColorPicker({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ColorPickerState();
  }
}

class _ColorPickerState extends ConsumerState<ConsumerStatefulWidget> {
  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  final debounce = const Duration(milliseconds: 350);

  @override
  Widget build(BuildContext context) {
    final color = ref.watch(deviceProvider
        .select((value) => Color(value.device?.properties.color ?? 0)));
    final color0 = useState(color);

    return n.Column([
      HueRingPicker(
        pickerColor: color0.value,
        displayThumbColor: false,
        onColorChanged: (c) {
          if (_timer?.isActive ?? false) _timer?.cancel();
          _timer = Timer(debounce, () {
            ref.read(bleManagerProvider.notifier).setStaticColor(c.value);
          });

          //
          ref.read(deviceProvider.notifier).setStaticColor(c.value);
          color0.value = c;
        },
        pickerAreaBorderRadius: BorderRadius.circular(16),
        colorPickerHeight: MediaQuery.of(context).size.height * 0.3,
        hueRingStrokeWidth: 25,
        portraitOnly: false,
        enableAlpha: false,
      ),
      BlockPicker(
        pickerColor: color,
        onColorChanged: (c) {
          if (_timer?.isActive ?? false) _timer?.cancel();
          _timer = Timer(debounce, () {
            ref.read(bleManagerProvider.notifier).setStaticColor(c.value);
          });

          //
          ref.read(deviceProvider.notifier).setStaticColor(c.value);
          color0.value = c;
        },
        layoutBuilder:
            (BuildContext context, List<Color> colors, PickerItem child) {
          Orientation orientation = MediaQuery.of(context).orientation;

          return SizedBox(
            width: 300,
            height: orientation == Orientation.portrait ? 360 : 200,
            child: GridView.count(
              crossAxisCount: orientation == Orientation.portrait ? 5 : 8,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              children: [for (Color color in colors) child(color)],
            ),
          );
        },
        itemBuilder: (color, isCurrent, changeColor) {
          return Container(
            margin: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: color,
            ),
            width: 1,
            height: 1,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: changeColor,
                borderRadius: BorderRadius.circular(16),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: isCurrent ? 1 : 0,
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          );
        },
      )
    ])
      ..mainAxisAlignment = MainAxisAlignment.center
      ..mt = 24
      ..wFull
      ..gap = 4;
  }
}
