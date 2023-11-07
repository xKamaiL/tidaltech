// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scenes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SceneTimeline _$SceneTimelineFromJson(Map<String, dynamic> json) =>
    SceneTimeline(
      duration: json['duration'] as int,
      color: Map<String, int>.from(json['color'] as Map),
    );

Map<String, dynamic> _$SceneTimelineToJson(SceneTimeline instance) =>
    <String, dynamic>{
      'duration': instance.duration,
      'color': instance.color,
    };

SceneItem _$SceneItemFromJson(Map<String, dynamic> json) => SceneItem(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      colors: (json['colors'] as List<dynamic>)
          .map((e) => SceneTimeline.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SceneItemToJson(SceneItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'colors': instance.colors,
    };

ListSceneParam _$ListSceneParamFromJson(Map<String, dynamic> json) =>
    ListSceneParam(
      query: (json['query'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ListSceneParamToJson(ListSceneParam instance) =>
    <String, dynamic>{
      'query': instance.query,
    };

ListSceneResult _$ListSceneResultFromJson(Map<String, dynamic> json) =>
    ListSceneResult(
      items: (json['items'] as List<dynamic>)
          .map((e) => SceneItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListSceneResultToJson(ListSceneResult instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
