import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

// LED that available on the product
enum LED {
  white, // 20
  blue, // 2
  royalBlue, // 36
  warmWhite, // 2
  ultraViolet, // 2
  red, // 1
  green, // 1
}

class ColorPriority {
  static const total = 64;
  final LED led;

  ColorPriority(this.led);

  double getOpacity() {
    switch (led) {
      case LED.white:
        return 0.3125; // 5/16
      case LED.blue:
        return 0.03125; // 1/32
      case LED.royalBlue:
        return 0.5625; // 9/16
      case LED.warmWhite:
        return 0.03125; // 1/32
      case LED.ultraViolet:
        return 0.03125; // 1/32
      case LED.red:
        return 0.015625; // 1/64
      case LED.green:
        return 0.015625; // 1/64
      default:
        return 0;
    }
  }
}

// ledColor Map config
const Map<LED, Color> ledColor = {
  LED.white: Colors.white,
  LED.blue: Color(0xFF0000FF),
  LED.royalBlue: Color(0xFF4169E1),
  LED.warmWhite: Color(0xFFfdf4dc),
  LED.ultraViolet: Color(0xFF9e00ff),
  LED.red: Colors.red,
  LED.green: Colors.green,
};
// how to access this config?
//

class FeederConfig {
  final List<TimePoint> points;

  const FeederConfig(this.points) : super();
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

@immutable
class TimePoint {
  final int id;
  final int hour;
  final int minute;

  // [ LED:{ColorPoint}, LED:{ColorPoint} ]
  final Map<LED, ColorPoint> colors;

  const TimePoint(
    this.id,
    this.hour,
    this.minute,
    this.colors,
  );

  @override
  String toString() {
    if (minute < 10) {
      return "$hour:0$minute";
    }
    return "$hour:$minute";
  }

  TimePoint copyWith({
    int? id,
    int? hour,
    int? minute,
    Map<LED, ColorPoint>? colors,
  }) {
    return TimePoint(
      id ?? this.id,
      hour ?? this.hour,
      minute ?? this.minute,
      colors ?? this.colors,
    );
  }

  // get full minutes
  int minutes() {
    return (hour * 60) + minute;
  }

  int hours() {
    return hour;
  }
}

class ColorPoint {
  final LED led;
  final int intensity;

  const ColorPoint(this.led, this.intensity);

  copyWith({required int intensity}) {
    return ColorPoint(led, intensity);
  }
}
