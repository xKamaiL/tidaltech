//
//  Generated code. Do not modify.
//  source: proto/message.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'message.pbenum.dart';

export 'message.pbenum.dart';

class DeviceInformationRequest extends $pb.GeneratedMessage {
  factory DeviceInformationRequest() => create();
  DeviceInformationRequest._() : super();
  factory DeviceInformationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeviceInformationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeviceInformationRequest', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeviceInformationRequest clone() => DeviceInformationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeviceInformationRequest copyWith(void Function(DeviceInformationRequest) updates) => super.copyWith((message) => updates(message as DeviceInformationRequest)) as DeviceInformationRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceInformationRequest create() => DeviceInformationRequest._();
  DeviceInformationRequest createEmptyInstance() => create();
  static $pb.PbList<DeviceInformationRequest> createRepeated() => $pb.PbList<DeviceInformationRequest>();
  @$core.pragma('dart2js:noInline')
  static DeviceInformationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeviceInformationRequest>(create);
  static DeviceInformationRequest? _defaultInstance;
}

class DeviceInformationResponse extends $pb.GeneratedMessage {
  factory DeviceInformationResponse() => create();
  DeviceInformationResponse._() : super();
  factory DeviceInformationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeviceInformationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeviceInformationResponse', createEmptyInstance: create)
    ..e<Mode>(1, _omitFieldNames ? '' : 'mode', $pb.PbFieldType.OE, defaultOrMaker: Mode.MODE_UNSPECIFIED, valueOf: Mode.valueOf, enumValues: Mode.values)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'currentTimestamps', $pb.PbFieldType.OU3)
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aOS(4, _omitFieldNames ? '' : 'id')
    ..aOS(5, _omitFieldNames ? '' : 'version')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeviceInformationResponse clone() => DeviceInformationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeviceInformationResponse copyWith(void Function(DeviceInformationResponse) updates) => super.copyWith((message) => updates(message as DeviceInformationResponse)) as DeviceInformationResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeviceInformationResponse create() => DeviceInformationResponse._();
  DeviceInformationResponse createEmptyInstance() => create();
  static $pb.PbList<DeviceInformationResponse> createRepeated() => $pb.PbList<DeviceInformationResponse>();
  @$core.pragma('dart2js:noInline')
  static DeviceInformationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeviceInformationResponse>(create);
  static DeviceInformationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Mode get mode => $_getN(0);
  @$pb.TagNumber(1)
  set mode(Mode v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMode() => $_has(0);
  @$pb.TagNumber(1)
  void clearMode() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get currentTimestamps => $_getIZ(1);
  @$pb.TagNumber(2)
  set currentTimestamps($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCurrentTimestamps() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrentTimestamps() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get id => $_getSZ(3);
  @$pb.TagNumber(4)
  set id($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasId() => $_has(3);
  @$pb.TagNumber(4)
  void clearId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get version => $_getSZ(4);
  @$pb.TagNumber(5)
  set version($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasVersion() => $_has(4);
  @$pb.TagNumber(5)
  void clearVersion() => clearField(5);
}

class LightingScheduleRequest extends $pb.GeneratedMessage {
  factory LightingScheduleRequest() => create();
  LightingScheduleRequest._() : super();
  factory LightingScheduleRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LightingScheduleRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LightingScheduleRequest', createEmptyInstance: create)
    ..pc<TimePointItem>(1, _omitFieldNames ? '' : 'points', $pb.PbFieldType.PM, subBuilder: TimePointItem.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LightingScheduleRequest clone() => LightingScheduleRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LightingScheduleRequest copyWith(void Function(LightingScheduleRequest) updates) => super.copyWith((message) => updates(message as LightingScheduleRequest)) as LightingScheduleRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LightingScheduleRequest create() => LightingScheduleRequest._();
  LightingScheduleRequest createEmptyInstance() => create();
  static $pb.PbList<LightingScheduleRequest> createRepeated() => $pb.PbList<LightingScheduleRequest>();
  @$core.pragma('dart2js:noInline')
  static LightingScheduleRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LightingScheduleRequest>(create);
  static LightingScheduleRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TimePointItem> get points => $_getList(0);
}

class SetSceneRequest extends $pb.GeneratedMessage {
  factory SetSceneRequest() => create();
  SetSceneRequest._() : super();
  factory SetSceneRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetSceneRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetSceneRequest', createEmptyInstance: create)
    ..e<Scene>(1, _omitFieldNames ? '' : 'scene', $pb.PbFieldType.OE, defaultOrMaker: Scene.SCENE_UNSPECIFIED, valueOf: Scene.valueOf, enumValues: Scene.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetSceneRequest clone() => SetSceneRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetSceneRequest copyWith(void Function(SetSceneRequest) updates) => super.copyWith((message) => updates(message as SetSceneRequest)) as SetSceneRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetSceneRequest create() => SetSceneRequest._();
  SetSceneRequest createEmptyInstance() => create();
  static $pb.PbList<SetSceneRequest> createRepeated() => $pb.PbList<SetSceneRequest>();
  @$core.pragma('dart2js:noInline')
  static SetSceneRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetSceneRequest>(create);
  static SetSceneRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Scene get scene => $_getN(0);
  @$pb.TagNumber(1)
  set scene(Scene v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasScene() => $_has(0);
  @$pb.TagNumber(1)
  void clearScene() => clearField(1);
}

class GetSceneResponse extends $pb.GeneratedMessage {
  factory GetSceneResponse() => create();
  GetSceneResponse._() : super();
  factory GetSceneResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSceneResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSceneResponse', createEmptyInstance: create)
    ..e<Scene>(1, _omitFieldNames ? '' : 'scene', $pb.PbFieldType.OE, defaultOrMaker: Scene.SCENE_UNSPECIFIED, valueOf: Scene.valueOf, enumValues: Scene.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSceneResponse clone() => GetSceneResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSceneResponse copyWith(void Function(GetSceneResponse) updates) => super.copyWith((message) => updates(message as GetSceneResponse)) as GetSceneResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSceneResponse create() => GetSceneResponse._();
  GetSceneResponse createEmptyInstance() => create();
  static $pb.PbList<GetSceneResponse> createRepeated() => $pb.PbList<GetSceneResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSceneResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSceneResponse>(create);
  static GetSceneResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Scene get scene => $_getN(0);
  @$pb.TagNumber(1)
  set scene(Scene v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasScene() => $_has(0);
  @$pb.TagNumber(1)
  void clearScene() => clearField(1);
}

class Effect extends $pb.GeneratedMessage {
  factory Effect() => create();
  Effect._() : super();
  factory Effect.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Effect.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Effect', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'duration', $pb.PbFieldType.OU3)
    ..pc<TimeStamp>(2, _omitFieldNames ? '' : 'timestamps', $pb.PbFieldType.PM, subBuilder: TimeStamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Effect clone() => Effect()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Effect copyWith(void Function(Effect) updates) => super.copyWith((message) => updates(message as Effect)) as Effect;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Effect create() => Effect._();
  Effect createEmptyInstance() => create();
  static $pb.PbList<Effect> createRepeated() => $pb.PbList<Effect>();
  @$core.pragma('dart2js:noInline')
  static Effect getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Effect>(create);
  static Effect? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get duration => $_getIZ(0);
  @$pb.TagNumber(1)
  set duration($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDuration() => $_has(0);
  @$pb.TagNumber(1)
  void clearDuration() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<TimeStamp> get timestamps => $_getList(1);
}

class UpgradeFirmwareRequest extends $pb.GeneratedMessage {
  factory UpgradeFirmwareRequest() => create();
  UpgradeFirmwareRequest._() : super();
  factory UpgradeFirmwareRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpgradeFirmwareRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpgradeFirmwareRequest', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpgradeFirmwareRequest clone() => UpgradeFirmwareRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpgradeFirmwareRequest copyWith(void Function(UpgradeFirmwareRequest) updates) => super.copyWith((message) => updates(message as UpgradeFirmwareRequest)) as UpgradeFirmwareRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpgradeFirmwareRequest create() => UpgradeFirmwareRequest._();
  UpgradeFirmwareRequest createEmptyInstance() => create();
  static $pb.PbList<UpgradeFirmwareRequest> createRepeated() => $pb.PbList<UpgradeFirmwareRequest>();
  @$core.pragma('dart2js:noInline')
  static UpgradeFirmwareRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpgradeFirmwareRequest>(create);
  static UpgradeFirmwareRequest? _defaultInstance;
}

class UpgradeFirmwareResponse extends $pb.GeneratedMessage {
  factory UpgradeFirmwareResponse() => create();
  UpgradeFirmwareResponse._() : super();
  factory UpgradeFirmwareResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpgradeFirmwareResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpgradeFirmwareResponse', createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isLatestVersion')
    ..aOS(2, _omitFieldNames ? '' : 'currentVersion')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpgradeFirmwareResponse clone() => UpgradeFirmwareResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpgradeFirmwareResponse copyWith(void Function(UpgradeFirmwareResponse) updates) => super.copyWith((message) => updates(message as UpgradeFirmwareResponse)) as UpgradeFirmwareResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpgradeFirmwareResponse create() => UpgradeFirmwareResponse._();
  UpgradeFirmwareResponse createEmptyInstance() => create();
  static $pb.PbList<UpgradeFirmwareResponse> createRepeated() => $pb.PbList<UpgradeFirmwareResponse>();
  @$core.pragma('dart2js:noInline')
  static UpgradeFirmwareResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpgradeFirmwareResponse>(create);
  static UpgradeFirmwareResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isLatestVersion => $_getBF(0);
  @$pb.TagNumber(1)
  set isLatestVersion($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIsLatestVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsLatestVersion() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get currentVersion => $_getSZ(1);
  @$pb.TagNumber(2)
  set currentVersion($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCurrentVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrentVersion() => clearField(2);
}

class TimePointItem extends $pb.GeneratedMessage {
  factory TimePointItem() => create();
  TimePointItem._() : super();
  factory TimePointItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TimePointItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TimePointItem', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'hh', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'mm', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'white', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'warmWhite', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'red', $pb.PbFieldType.OU3)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'green', $pb.PbFieldType.OU3)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'blue', $pb.PbFieldType.OU3)
    ..a<$core.int>(8, _omitFieldNames ? '' : 'royalBlue', $pb.PbFieldType.OU3)
    ..a<$core.int>(9, _omitFieldNames ? '' : 'ultraViolet', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TimePointItem clone() => TimePointItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TimePointItem copyWith(void Function(TimePointItem) updates) => super.copyWith((message) => updates(message as TimePointItem)) as TimePointItem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TimePointItem create() => TimePointItem._();
  TimePointItem createEmptyInstance() => create();
  static $pb.PbList<TimePointItem> createRepeated() => $pb.PbList<TimePointItem>();
  @$core.pragma('dart2js:noInline')
  static TimePointItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TimePointItem>(create);
  static TimePointItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get hh => $_getIZ(0);
  @$pb.TagNumber(1)
  set hh($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHh() => $_has(0);
  @$pb.TagNumber(1)
  void clearHh() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get mm => $_getIZ(1);
  @$pb.TagNumber(2)
  set mm($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMm() => $_has(1);
  @$pb.TagNumber(2)
  void clearMm() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get white => $_getIZ(2);
  @$pb.TagNumber(3)
  set white($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasWhite() => $_has(2);
  @$pb.TagNumber(3)
  void clearWhite() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get warmWhite => $_getIZ(3);
  @$pb.TagNumber(4)
  set warmWhite($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasWarmWhite() => $_has(3);
  @$pb.TagNumber(4)
  void clearWarmWhite() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get red => $_getIZ(4);
  @$pb.TagNumber(5)
  set red($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRed() => $_has(4);
  @$pb.TagNumber(5)
  void clearRed() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get green => $_getIZ(5);
  @$pb.TagNumber(6)
  set green($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasGreen() => $_has(5);
  @$pb.TagNumber(6)
  void clearGreen() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get blue => $_getIZ(6);
  @$pb.TagNumber(7)
  set blue($core.int v) { $_setUnsignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasBlue() => $_has(6);
  @$pb.TagNumber(7)
  void clearBlue() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get royalBlue => $_getIZ(7);
  @$pb.TagNumber(8)
  set royalBlue($core.int v) { $_setUnsignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasRoyalBlue() => $_has(7);
  @$pb.TagNumber(8)
  void clearRoyalBlue() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get ultraViolet => $_getIZ(8);
  @$pb.TagNumber(9)
  set ultraViolet($core.int v) { $_setUnsignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasUltraViolet() => $_has(8);
  @$pb.TagNumber(9)
  void clearUltraViolet() => clearField(9);
}

class Brightness extends $pb.GeneratedMessage {
  factory Brightness() => create();
  Brightness._() : super();
  factory Brightness.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Brightness.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Brightness', createEmptyInstance: create)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'white', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'warmWhite', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'red', $pb.PbFieldType.OU3)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'green', $pb.PbFieldType.OU3)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'blue', $pb.PbFieldType.OU3)
    ..a<$core.int>(8, _omitFieldNames ? '' : 'royalBlue', $pb.PbFieldType.OU3)
    ..a<$core.int>(9, _omitFieldNames ? '' : 'ultraViolet', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Brightness clone() => Brightness()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Brightness copyWith(void Function(Brightness) updates) => super.copyWith((message) => updates(message as Brightness)) as Brightness;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Brightness create() => Brightness._();
  Brightness createEmptyInstance() => create();
  static $pb.PbList<Brightness> createRepeated() => $pb.PbList<Brightness>();
  @$core.pragma('dart2js:noInline')
  static Brightness getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Brightness>(create);
  static Brightness? _defaultInstance;

  @$pb.TagNumber(3)
  $core.int get white => $_getIZ(0);
  @$pb.TagNumber(3)
  set white($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(3)
  $core.bool hasWhite() => $_has(0);
  @$pb.TagNumber(3)
  void clearWhite() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get warmWhite => $_getIZ(1);
  @$pb.TagNumber(4)
  set warmWhite($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(4)
  $core.bool hasWarmWhite() => $_has(1);
  @$pb.TagNumber(4)
  void clearWarmWhite() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get red => $_getIZ(2);
  @$pb.TagNumber(5)
  set red($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(5)
  $core.bool hasRed() => $_has(2);
  @$pb.TagNumber(5)
  void clearRed() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get green => $_getIZ(3);
  @$pb.TagNumber(6)
  set green($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(6)
  $core.bool hasGreen() => $_has(3);
  @$pb.TagNumber(6)
  void clearGreen() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get blue => $_getIZ(4);
  @$pb.TagNumber(7)
  set blue($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(7)
  $core.bool hasBlue() => $_has(4);
  @$pb.TagNumber(7)
  void clearBlue() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get royalBlue => $_getIZ(5);
  @$pb.TagNumber(8)
  set royalBlue($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(8)
  $core.bool hasRoyalBlue() => $_has(5);
  @$pb.TagNumber(8)
  void clearRoyalBlue() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get ultraViolet => $_getIZ(6);
  @$pb.TagNumber(9)
  set ultraViolet($core.int v) { $_setUnsignedInt32(6, v); }
  @$pb.TagNumber(9)
  $core.bool hasUltraViolet() => $_has(6);
  @$pb.TagNumber(9)
  void clearUltraViolet() => clearField(9);
}

class TimeStamp extends $pb.GeneratedMessage {
  factory TimeStamp() => create();
  TimeStamp._() : super();
  factory TimeStamp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TimeStamp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TimeStamp', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'seconds', $pb.PbFieldType.OU3)
    ..aOM<Brightness>(2, _omitFieldNames ? '' : 'brightness', subBuilder: Brightness.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TimeStamp clone() => TimeStamp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TimeStamp copyWith(void Function(TimeStamp) updates) => super.copyWith((message) => updates(message as TimeStamp)) as TimeStamp;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TimeStamp create() => TimeStamp._();
  TimeStamp createEmptyInstance() => create();
  static $pb.PbList<TimeStamp> createRepeated() => $pb.PbList<TimeStamp>();
  @$core.pragma('dart2js:noInline')
  static TimeStamp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TimeStamp>(create);
  static TimeStamp? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get seconds => $_getIZ(0);
  @$pb.TagNumber(1)
  set seconds($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSeconds() => $_has(0);
  @$pb.TagNumber(1)
  void clearSeconds() => clearField(1);

  @$pb.TagNumber(2)
  Brightness get brightness => $_getN(1);
  @$pb.TagNumber(2)
  set brightness(Brightness v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasBrightness() => $_has(1);
  @$pb.TagNumber(2)
  void clearBrightness() => clearField(2);
  @$pb.TagNumber(2)
  Brightness ensureBrightness() => $_ensure(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
