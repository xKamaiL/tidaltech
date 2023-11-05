// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PresetItem _$PresetItemFromJson(Map<String, dynamic> json) => PresetItem(
      id: json['id'] as String,
      name: json['name'] as String,
      schedule:
          DeviceSchedule.fromJson(json['schedule'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PresetItemToJson(PresetItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'schedule': instance.schedule,
    };

MyPresetResult _$MyPresetResultFromJson(Map<String, dynamic> json) =>
    MyPresetResult(
      items: (json['items'] as List<dynamic>)
          .map((e) => PresetItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyPresetResultToJson(MyPresetResult instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

CreatePresetParam _$CreatePresetParamFromJson(Map<String, dynamic> json) =>
    CreatePresetParam(
      name: json['name'] as String,
      schedule:
          DeviceSchedule.fromJson(json['schedule'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreatePresetParamToJson(CreatePresetParam instance) =>
    <String, dynamic>{
      'name': instance.name,
      'schedule': instance.schedule,
    };

DeletePresetParam _$DeletePresetParamFromJson(Map<String, dynamic> json) =>
    DeletePresetParam(
      id: json['id'] as String,
    );

Map<String, dynamic> _$DeletePresetParamToJson(DeletePresetParam instance) =>
    <String, dynamic>{
      'id': instance.id,
    };
