import 'package:json_annotation/json_annotation.dart';
import 'package:tidal_tech/providers/feeder.dart';

part 'scenes.g.dart';

@JsonSerializable()
class SceneTimeline {
  final int duration;
  final Map<LED, int> color;

  SceneTimeline({required this.duration, required this.color});

  factory SceneTimeline.fromJson(Map<String, dynamic> json) =>
      _$SceneTimelineFromJson(json);

  Map<String, dynamic> toJson() => _$SceneTimelineToJson(this);
}

@JsonSerializable()
class SceneItem {
  final String id;
  final String name;
  final String icon;
  final List<SceneTimeline> colors;

  SceneItem({
    required this.id,
    required this.name,
    required this.icon,
    required this.colors,
  });

  factory SceneItem.fromJson(Map<String, dynamic> json) =>
      _$SceneItemFromJson(json);

  Map<String, dynamic> toJson() => _$SceneItemToJson(this);
}

@JsonSerializable()
class ListSceneParam {
  final List<String> query;

  ListSceneParam({required this.query});

  factory ListSceneParam.fromJson(Map<String, dynamic> json) =>
      _$ListSceneParamFromJson(json);

  Map<String, dynamic> toJson() => _$ListSceneParamToJson(this);
}

@JsonSerializable()
class ListSceneResult {
  final List<SceneItem> items;

  ListSceneResult({required this.items});

  factory ListSceneResult.fromJson(Map<String, dynamic> json) =>
      _$ListSceneResultFromJson(json);

  Map<String, dynamic> toJson() => _$ListSceneResultToJson(this);
}

@JsonSerializable()
class GetSceneParam {
  final String id;

  GetSceneParam({required this.id});

  factory GetSceneParam.fromJson(Map<String, dynamic> json) =>
      _$GetSceneParamFromJson(json);

  Map<String, dynamic> toJson() => _$GetSceneParamToJson(this);
}
