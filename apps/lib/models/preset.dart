import 'package:json_annotation/json_annotation.dart';
import 'package:tidal_tech/models/devices.dart';

part 'preset.g.dart';

@JsonSerializable()
class PresetItem {
  final String id;
  final String name;
  final String description;
  final List<DeviceTimePoint>? timePoints;
  final bool isPublic;

  PresetItem({
    required this.id,
    required this.name,
    required this.timePoints,
    required this.description,
    required this.isPublic,
  });

  factory PresetItem.fromJson(Map<String, dynamic> json) =>
      _$PresetItemFromJson(json);

  Map<String, dynamic> toJson() => _$PresetItemToJson(this);
}

@JsonSerializable()
class MyPresetResult {
  final List<PresetItem> items;

  MyPresetResult({required this.items});

  factory MyPresetResult.fromJson(Map<String, dynamic> json) =>
      _$MyPresetResultFromJson(json);

  Map<String, dynamic> toJson() => _$MyPresetResultToJson(this);
}

@JsonSerializable()
class CreatePresetParam {
  final String name;
  final List<DeviceTimePoint>? timePoints;

  CreatePresetParam({required this.name, required this.timePoints});

  factory CreatePresetParam.fromJson(Map<String, dynamic> json) =>
      _$CreatePresetParamFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePresetParamToJson(this);
}

@JsonSerializable()
class DeletePresetParam {
  final String id;

  DeletePresetParam({required this.id});

  factory DeletePresetParam.fromJson(Map<String, dynamic> json) =>
      _$DeletePresetParamFromJson(json);

  Map<String, dynamic> toJson() => _$DeletePresetParamToJson(this);
}
