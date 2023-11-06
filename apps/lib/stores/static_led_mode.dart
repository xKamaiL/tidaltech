import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tidal_tech/providers/feeder.dart';

final staticLEDColorProvider =
    StateNotifierProvider<StaticLEDColor, StaticLEDColorState>((ref) {
  return StaticLEDColor();
});

@immutable
class StaticLEDColorState {
  final Map<LED, ColorPoint> colors = {
    LED.white: const ColorPoint(LED.white, 0),
    LED.blue: const ColorPoint(LED.blue, 0),
    LED.royalBlue: const ColorPoint(LED.royalBlue, 0),
    LED.warmWhite: const ColorPoint(LED.warmWhite, 0),
    LED.ultraViolet: const ColorPoint(LED.ultraViolet, 0),
    LED.red: const ColorPoint(LED.red, 0),
    LED.green: const ColorPoint(LED.green, 0),
  };

  StaticLEDColorState();

  copyWith(Map<LED, ColorPoint> colors) {
    return StaticLEDColorState()..colors.addAll(colors);
  }
}

class StaticLEDColor extends StateNotifier<StaticLEDColorState> {
  StaticLEDColor() : super(StaticLEDColorState());

  void setWhite(double value) {
    state = state.copyWith(
      {
        ...state.colors,
        LED.white: ColorPoint(LED.white, value.toInt()),
      },
    );
  }

  void setBlue(double value) {
    state = state.copyWith({
      ...state.colors,
      LED.blue: ColorPoint(LED.blue, value.toInt()),
    });
  }

  void setRoyalBlue(double value) {
    state = state.copyWith({
      ...state.colors,
      LED.royalBlue: ColorPoint(LED.royalBlue, value.toInt()),
    });
  }

  void setWarmWhite(double value) {
    state = state.copyWith({
      ...state.colors,
      LED.warmWhite: ColorPoint(LED.warmWhite, value.toInt()),
    });
  }

  void setUltraViolet(double value) {
    state = state.copyWith({
      ...state.colors,
      LED.ultraViolet: ColorPoint(LED.ultraViolet, value.toInt()),
    });
  }

  void setRed(double value) {
    state = state.copyWith({
      ...state.colors,
      LED.red: ColorPoint(LED.red, value.toInt()),
    });
  }

  void setGreen(double value) {
    state = state.copyWith({
      ...state.colors,
      LED.green: ColorPoint(LED.green, value.toInt()),
    });
  }
}
