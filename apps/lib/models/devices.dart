import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'devices.g.dart';

@JsonSerializable()
class DeviceTimePoint {
  final String time;
  final Map<String, int> brightness;

  DeviceTimePoint({
    required this.time,
    required this.brightness,
  });
//
}

@JsonSerializable()
class DeviceSchedule {
  final List<DeviceTimePoint>? points;
  final int weekday;

  DeviceSchedule({
    required this.points,
    required this.weekday,
  });
}

@JsonSerializable()
class DeviceProperties {
  final bool power;
  final String mode;
  final DeviceSchedule schedule;

  DeviceProperties({
    required this.power,
    required this.mode,
    required this.schedule,
  });
//
}

@JsonSerializable()
class DeviceItem {
  final String id;
  final String name;

  final String? pairUserId;
  final DateTime? pairAt;
  final DateTime? createdAt;

  final DeviceProperties properties;

  DeviceItem({
    required this.id,
    required this.name,
    required this.pairAt,
    required this.pairUserId,
    required this.createdAt,
    required this.properties,
  });

//
}
