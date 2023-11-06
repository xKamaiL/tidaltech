import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tidal_tech/proto/message.pb.dart';

import '../models/devices.dart';

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

  DeviceTimePoint toDeviceTimePoint() {
    return DeviceTimePoint(
      time:
          "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}",
      brightness: {
        "white": colors[LED.white]!.intensity,
        "blue": colors[LED.blue]!.intensity,
        "royalBlue": colors[LED.royalBlue]!.intensity,
        "warmWhite": colors[LED.warmWhite]!.intensity,
        "ultraViolet": colors[LED.ultraViolet]!.intensity,
        "red": colors[LED.red]!.intensity,
        "green": colors[LED.green]!.intensity,
      },
    );
  }

  LightingScheduleRequest toProto() {
    final proto = LightingScheduleRequest();
    if (hour > 0) {
      proto.hh = hour;
    }
    if (minute > 0) {
      proto.mm = minute;
    }

    if (colors[LED.white]!.intensity > 0) {
      proto.white = colors[LED.white]!.intensity;
    }
    if (colors[LED.warmWhite]!.intensity > 0) {
      proto.warmWhite = colors[LED.warmWhite]!.intensity;
    }
    if (colors[LED.red]!.intensity > 0) {
      proto.red = colors[LED.red]!.intensity;
    }
    if (colors[LED.green]!.intensity > 0) {
      proto.green = colors[LED.green]!.intensity;
    }
    if (colors[LED.blue]!.intensity > 0) {
      proto.blue = colors[LED.blue]!.intensity;
    }
    if (colors[LED.royalBlue]!.intensity > 0) {
      proto.royalBlue = colors[LED.royalBlue]!.intensity;
    }
    if (colors[LED.ultraViolet]!.intensity > 0) {
      proto.ultraViolet = colors[LED.ultraViolet]!.intensity;
    }
    return proto;
  }
}

class ColorPoint {
  final LED led;
  final int intensity;

  const ColorPoint(this.led, this.intensity);

  copyWith({required int intensity}) {
    return ColorPoint(led, intensity);
  }

// to U8List
}
