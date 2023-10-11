import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class DeviceInformationService {
  static String getDeviceName = ("c833d84a-56c9-46a9-8717-8210cc30bc69");
  static String getDeviceId = ("bd131062-7e70-4391-8555-88f655c3c334");
}

class ColorService {
  static String getColorMode = ("f5057e16-c769-4a17-99f7-79b03dcac1c7");
  static String setColorMode = ("7808c1c0-632f-475f-a3f1-d49b5d7dec69");

  static String listTimePoints = ("940e68e7-9b45-4de4-a034-c7a40855702c");
}

class RTCService {
  static String getCurrentTime = ("0ac1599e-0a32-42c2-b890-64d63a47afb3");
  static String setCurrentTime = ("c99edcca-4af2-4bd9-a791-a40e0e2d86e5");
}

class BLEServices {
  // static const deviceInformation = "2840ef22-f2ba-46b7-a1d4-cd06ce7e65b9";
  static const deviceInformation = "b9657ece-06cd-d4a1-b746-baf222ef4028";
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
