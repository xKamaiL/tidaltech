import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

// LED that available on the product
enum LED {
  white,
  blue,
  royalBlue,
  warmWhite,
  ultraViolet,
  red,
  green,
}

// ledColor Map config
const Map<LED, Color> ledColor = {
  LED.white: Colors.white,
  LED.blue: Color(0xFF4169E1),
  LED.royalBlue: Color(0xFF0000FF),
  LED.warmWhite: Color(0xFFfdf4dc),
  LED.ultraViolet: Color(0xFF9e00ff),
  LED.red: Colors.red,
  LED.green: Colors.green,
};
// how to access this config?
//

class FeederConfig {
  final List<TimePoint> points;

  FeederConfig(this.points) : super();

//
}

class HourMinute {
  final int hour;
  final int minute;

  HourMinute(this.hour, this.minute);

  @override
  String toString() {
    return "$hour:$minute";
  }
}

class TimePoint {
  final int hour;
  final int minute;

  // [ LED:{ColorPoint}, LED:{ColorPoint} ]
  late final List<Map<LED, ColorPoint>> colors;

  TimePoint(
    this.hour,
    this.minute, {
    this.colors = const [],
  }) {
    init();
  }

  void init() {
    colors = <Map<LED, ColorPoint>>[
      {
        LED.white: const ColorPoint(LED.white, 0),
        LED.blue: const ColorPoint(LED.blue, 0),
        LED.royalBlue: const ColorPoint(LED.royalBlue, 0),
        LED.warmWhite: const ColorPoint(LED.warmWhite, 0),
        LED.ultraViolet: const ColorPoint(LED.ultraViolet, 0),
        LED.red: const ColorPoint(LED.red, 0),
        LED.green: const ColorPoint(LED.green, 0),
      }
    ];
  }

  @override
  String toString() {
    return "$hour:$minute";
  }

  int minutes() {
    return hour * 60 + minute;
  }

  int hours() {
    return hour;
  }
}

class ColorPoint {
  final LED led;
  final int intensity;

  const ColorPoint(this.led, this.intensity);
}
