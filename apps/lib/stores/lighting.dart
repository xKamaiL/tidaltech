import 'package:hooks_riverpod/hooks_riverpod.dart';

enum LightingMode { ambient, feed }

final lightingModeProvider =
    StateNotifierProvider<LightingModeProvider, LightingMode>(
        (ref) => LightingModeProvider(LightingMode.feed));

class LightingModeProvider extends StateNotifier<LightingMode> {
  LightingModeProvider(super.state);

  void setMode(LightingMode value) async {
    state = value;
  }
}
