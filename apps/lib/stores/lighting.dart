import 'package:hooks_riverpod/hooks_riverpod.dart';

enum LightingMode { custom, preset }

final lightingModeProvider = StateNotifierProvider<LightingModeProvider, LightingMode>(
    (ref) => LightingModeProvider(LightingMode.custom));

class LightingModeProvider extends StateNotifier<LightingMode> {
  LightingModeProvider(super.state);

  void setMode(LightingMode value) {
    state = value;
  }
}
