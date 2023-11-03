// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'devices.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceTimePoint _$DeviceTimePointFromJson(Map<String, dynamic> json) =>
    DeviceTimePoint(
      time: json['time'] as String,
      brightness: Map<String, int>.from(json['brightness'] as Map),
    );

Map<String, dynamic> _$DeviceTimePointToJson(DeviceTimePoint instance) =>
    <String, dynamic>{
      'time': instance.time,
      'brightness': instance.brightness,
    };

DeviceSchedule _$DeviceScheduleFromJson(Map<String, dynamic> json) =>
    DeviceSchedule(
      points: (json['points'] as List<dynamic>?)
          ?.map((e) => DeviceTimePoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      weekday: json['weekday'] as int,
    );

Map<String, dynamic> _$DeviceScheduleToJson(DeviceSchedule instance) =>
    <String, dynamic>{
      'points': instance.points,
      'weekday': instance.weekday,
    };

DeviceProperties _$DevicePropertiesFromJson(Map<String, dynamic> json) =>
    DeviceProperties(
      power: json['power'] as bool,
      mode: json['mode'] as String,
      schedule:
          DeviceSchedule.fromJson(json['schedule'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DevicePropertiesToJson(DeviceProperties instance) =>
    <String, dynamic>{
      'power': instance.power,
      'mode': instance.mode,
      'schedule': instance.schedule,
    };

DeviceItem _$DeviceItemFromJson(Map<String, dynamic> json) => DeviceItem(
      id: json['id'] as String,
      name: json['name'] as String,
      pairAt: json['pairAt'] == null
          ? null
          : DateTime.parse(json['pairAt'] as String),
      pairUserId: json['pairUserId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      properties:
          DeviceProperties.fromJson(json['properties'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DeviceItemToJson(DeviceItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pairUserId': instance.pairUserId,
      'pairAt': instance.pairAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'properties': instance.properties,
    };

PairParam _$PairParamFromJson(Map<String, dynamic> json) => PairParam(
      id: json['id'] as String,
    );

Map<String, dynamic> _$PairParamToJson(PairParam instance) => <String, dynamic>{
      'id': instance.id,
    };

UnPairParam _$UnPairParamFromJson(Map<String, dynamic> json) => UnPairParam(
      id: json['id'] as String,
    );

Map<String, dynamic> _$UnPairParamToJson(UnPairParam instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

UpdateScheduleParam _$UpdateScheduleParamFromJson(Map<String, dynamic> json) =>
    UpdateScheduleParam(
      schedule:
          DeviceSchedule.fromJson(json['schedule'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateScheduleParamToJson(
        UpdateScheduleParam instance) =>
    <String, dynamic>{
      'schedule': instance.schedule,
    };
