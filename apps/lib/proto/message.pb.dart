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

class SetColorModeRequest extends $pb.GeneratedMessage {
  factory SetColorModeRequest() => create();
  SetColorModeRequest._() : super();
  factory SetColorModeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetColorModeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetColorModeRequest', createEmptyInstance: create)
    ..e<Mode>(1, _omitFieldNames ? '' : 'mode', $pb.PbFieldType.OE, defaultOrMaker: Mode.MODE_UNSPECIFIED, valueOf: Mode.valueOf, enumValues: Mode.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetColorModeRequest clone() => SetColorModeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetColorModeRequest copyWith(void Function(SetColorModeRequest) updates) => super.copyWith((message) => updates(message as SetColorModeRequest)) as SetColorModeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetColorModeRequest create() => SetColorModeRequest._();
  SetColorModeRequest createEmptyInstance() => create();
  static $pb.PbList<SetColorModeRequest> createRepeated() => $pb.PbList<SetColorModeRequest>();
  @$core.pragma('dart2js:noInline')
  static SetColorModeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetColorModeRequest>(create);
  static SetColorModeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Mode get mode => $_getN(0);
  @$pb.TagNumber(1)
  set mode(Mode v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMode() => $_has(0);
  @$pb.TagNumber(1)
  void clearMode() => clearField(1);
}

class SetAmbientRequest extends $pb.GeneratedMessage {
  factory SetAmbientRequest() => create();
  SetAmbientRequest._() : super();
  factory SetAmbientRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetAmbientRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetAmbientRequest', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'r', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'g', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'b', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetAmbientRequest clone() => SetAmbientRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetAmbientRequest copyWith(void Function(SetAmbientRequest) updates) => super.copyWith((message) => updates(message as SetAmbientRequest)) as SetAmbientRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetAmbientRequest create() => SetAmbientRequest._();
  SetAmbientRequest createEmptyInstance() => create();
  static $pb.PbList<SetAmbientRequest> createRepeated() => $pb.PbList<SetAmbientRequest>();
  @$core.pragma('dart2js:noInline')
  static SetAmbientRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetAmbientRequest>(create);
  static SetAmbientRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get r => $_getIZ(0);
  @$pb.TagNumber(1)
  set r($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasR() => $_has(0);
  @$pb.TagNumber(1)
  void clearR() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get g => $_getIZ(1);
  @$pb.TagNumber(2)
  set g($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasG() => $_has(1);
  @$pb.TagNumber(2)
  void clearG() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get b => $_getIZ(2);
  @$pb.TagNumber(3)
  set b($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasB() => $_has(2);
  @$pb.TagNumber(3)
  void clearB() => clearField(3);
}

class ListTimePointRequest_Time extends $pb.GeneratedMessage {
  factory ListTimePointRequest_Time() => create();
  ListTimePointRequest_Time._() : super();
  factory ListTimePointRequest_Time.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListTimePointRequest_Time.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListTimePointRequest.Time', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'hh', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'mm', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListTimePointRequest_Time clone() => ListTimePointRequest_Time()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListTimePointRequest_Time copyWith(void Function(ListTimePointRequest_Time) updates) => super.copyWith((message) => updates(message as ListTimePointRequest_Time)) as ListTimePointRequest_Time;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListTimePointRequest_Time create() => ListTimePointRequest_Time._();
  ListTimePointRequest_Time createEmptyInstance() => create();
  static $pb.PbList<ListTimePointRequest_Time> createRepeated() => $pb.PbList<ListTimePointRequest_Time>();
  @$core.pragma('dart2js:noInline')
  static ListTimePointRequest_Time getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListTimePointRequest_Time>(create);
  static ListTimePointRequest_Time? _defaultInstance;

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
}

class ListTimePointRequest extends $pb.GeneratedMessage {
  factory ListTimePointRequest() => create();
  ListTimePointRequest._() : super();
  factory ListTimePointRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListTimePointRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListTimePointRequest', createEmptyInstance: create)
    ..pc<ListTimePointRequest_Time>(1, _omitFieldNames ? '' : 'times', $pb.PbFieldType.PM, subBuilder: ListTimePointRequest_Time.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListTimePointRequest clone() => ListTimePointRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListTimePointRequest copyWith(void Function(ListTimePointRequest) updates) => super.copyWith((message) => updates(message as ListTimePointRequest)) as ListTimePointRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListTimePointRequest create() => ListTimePointRequest._();
  ListTimePointRequest createEmptyInstance() => create();
  static $pb.PbList<ListTimePointRequest> createRepeated() => $pb.PbList<ListTimePointRequest>();
  @$core.pragma('dart2js:noInline')
  static ListTimePointRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListTimePointRequest>(create);
  static ListTimePointRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ListTimePointRequest_Time> get times => $_getList(0);
}

class LightingScheduleRequest extends $pb.GeneratedMessage {
  factory LightingScheduleRequest() => create();
  LightingScheduleRequest._() : super();
  factory LightingScheduleRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LightingScheduleRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LightingScheduleRequest', createEmptyInstance: create)
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

class TimeStamp extends $pb.GeneratedMessage {
  factory TimeStamp() => create();
  TimeStamp._() : super();
  factory TimeStamp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TimeStamp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TimeStamp', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'seconds', $pb.PbFieldType.OU3)
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

  @$pb.TagNumber(3)
  $core.int get white => $_getIZ(1);
  @$pb.TagNumber(3)
  set white($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(3)
  $core.bool hasWhite() => $_has(1);
  @$pb.TagNumber(3)
  void clearWhite() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get warmWhite => $_getIZ(2);
  @$pb.TagNumber(4)
  set warmWhite($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasWarmWhite() => $_has(2);
  @$pb.TagNumber(4)
  void clearWarmWhite() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get red => $_getIZ(3);
  @$pb.TagNumber(5)
  set red($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasRed() => $_has(3);
  @$pb.TagNumber(5)
  void clearRed() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get green => $_getIZ(4);
  @$pb.TagNumber(6)
  set green($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(6)
  $core.bool hasGreen() => $_has(4);
  @$pb.TagNumber(6)
  void clearGreen() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get blue => $_getIZ(5);
  @$pb.TagNumber(7)
  set blue($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(7)
  $core.bool hasBlue() => $_has(5);
  @$pb.TagNumber(7)
  void clearBlue() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get royalBlue => $_getIZ(6);
  @$pb.TagNumber(8)
  set royalBlue($core.int v) { $_setUnsignedInt32(6, v); }
  @$pb.TagNumber(8)
  $core.bool hasRoyalBlue() => $_has(6);
  @$pb.TagNumber(8)
  void clearRoyalBlue() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get ultraViolet => $_getIZ(7);
  @$pb.TagNumber(9)
  set ultraViolet($core.int v) { $_setUnsignedInt32(7, v); }
  @$pb.TagNumber(9)
  $core.bool hasUltraViolet() => $_has(7);
  @$pb.TagNumber(9)
  void clearUltraViolet() => clearField(9);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
