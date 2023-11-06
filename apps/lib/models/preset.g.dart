// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PresetItem _$PresetItemFromJson(Map<String, dynamic> json) => PresetItem(
      id: json['id'] as String,
      name: json['name'] as String,
      timePoints: (json['timePoints'] as List<dynamic>?)
          ?.map((e) => DeviceTimePoint.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PresetItemToJson(PresetItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'timePoints': instance.timePoints,
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
      timePoints: (json['timePoints'] as List<dynamic>?)
          ?.map((e) => DeviceTimePoint.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreatePresetParamToJson(CreatePresetParam instance) =>
    <String, dynamic>{
      'name': instance.name,
      'timePoints': instance.timePoints,
    };

DeletePresetParam _$DeletePresetParamFromJson(Map<String, dynamic> json) =>
    DeletePresetParam(
      id: json['id'] as String,
    );

Map<String, dynamic> _$DeletePresetParamToJson(DeletePresetParam instance) =>
    <String, dynamic>{
      'id': instance.id,
    };
