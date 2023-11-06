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
  final Map<String, int> colors;

  DeviceProperties({
    required this.power,
    required this.mode,
    required this.schedule,
    required this.colors,
  });

  factory DeviceProperties.fromJson(Map<String, dynamic> json) =>
      _$DevicePropertiesFromJson(json);

  Map<String, dynamic> toJson() => _$DevicePropertiesToJson(this);

  copyWith({
    bool? power,
    String? mode,
    DeviceSchedule? schedule,
    Map<String, int>? color,
  }) {
    return DeviceProperties(
      power: power ?? this.power,
      mode: mode ?? this.mode,
      schedule: schedule ?? this.schedule,
      colors: color ?? colors,
    );
  }
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

  copyWith({
    String? id,
    String? name,
    String? pairUserId,
    DateTime? pairAt,
    DateTime? createdAt,
    DeviceProperties? properties,
  }) {
    return DeviceItem(
      id: id ?? this.id,
      name: name ?? this.name,
      pairUserId: pairUserId ?? this.pairUserId,
      pairAt: pairAt ?? this.pairAt,
      createdAt: createdAt ?? this.createdAt,
      properties: properties ?? this.properties,
    );
  }
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

@JsonSerializable()
class UpdateScheduleParam {
  final DeviceSchedule schedule;

  UpdateScheduleParam({required this.schedule});

  factory UpdateScheduleParam.fromJson(Map<String, dynamic> json) =>
      _$UpdateScheduleParamFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateScheduleParamToJson(this);
}

@JsonSerializable()
class UpdateModeParam {
  final String mode;

  UpdateModeParam({required this.mode});

  factory UpdateModeParam.fromJson(Map<String, dynamic> json) =>
      _$UpdateModeParamFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateModeParamToJson(this);
}

@JsonSerializable()
class UpdateStaticColorParam {
  final Map<String, int> colors;

  UpdateStaticColorParam({required this.colors});

  factory UpdateStaticColorParam.fromJson(Map<String, dynamic> json) =>
      _$UpdateStaticColorParamFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateStaticColorParamToJson(this);
}
