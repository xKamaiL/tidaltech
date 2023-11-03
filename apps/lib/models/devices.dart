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

  factory DeviceTimePoint.fromJson(Map<String, dynamic> json) =>
      _$DeviceTimePointFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceTimePointToJson(this);
}

@JsonSerializable()
class DeviceSchedule {
  final List<DeviceTimePoint>? points;
  final int weekday;

  DeviceSchedule({
    required this.points,
    required this.weekday,
  });

  factory DeviceSchedule.fromJson(Map<String, dynamic> json) =>
      _$DeviceScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceScheduleToJson(this);
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

  factory DeviceProperties.fromJson(Map<String, dynamic> json) =>
      _$DevicePropertiesFromJson(json);

  Map<String, dynamic> toJson() => _$DevicePropertiesToJson(this);
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

  factory DeviceItem.fromJson(Map<String, dynamic> json) =>
      _$DeviceItemFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceItemToJson(this);
}

@JsonSerializable()
class PairParam {
  final String id;

  PairParam({required this.id});

  factory PairParam.fromJson(Map<String, dynamic> json) =>
      _$PairParamFromJson(json);

  Map<String, dynamic> toJson() => _$PairParamToJson(this);
}

@JsonSerializable()
class UnPairParam {
  final String id;

  UnPairParam({required this.id});

  factory UnPairParam.fromJson(Map<String, dynamic> json) =>
      _$UnPairParamFromJson(json);

  Map<String, dynamic> toJson() => _$UnPairParamToJson(this);
}
