import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum LightingMode { ambient, feed }

final lightingModeProvider =
    StateNotifierProvider<LightingModeProvider, LightingMode>(
        (ref) => LightingModeProvider(LightingMode.feed));

class LightingModeProvider extends StateNotifier<LightingMode> {
  LightingModeProvider(super.state);

  void setMode(LightingMode value) {
    state = value;
  }
}
