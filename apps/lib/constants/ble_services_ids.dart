import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BLEServices {
  static const deviceInformation = "2840ef22-f2ba-46b7-a1d4-cd06ce7e65b9";
  static const color = "72b60562-580c-4946-b3b5-8bd8bf8d8c5b";
  static const rtc = "2f659cc6-7bdc-4c2a-966f-2411706b0b85";

  static List<Guid> list() {
    return [
      Guid(deviceInformation),
      Guid(color),
      Guid(rtc),
    ];
  }
}
