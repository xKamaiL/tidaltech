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

enum Lighting_Data {
  schedule, 
  effect, 
  rgb, 
  notSet
}

class Lighting extends $pb.GeneratedMessage {
  factory Lighting() => create();
  Lighting._() : super();
  factory Lighting.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Lighting.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, Lighting_Data> _Lighting_DataByTag = {
    2 : Lighting_Data.schedule,
    3 : Lighting_Data.effect,
    4 : Lighting_Data.rgb,
    0 : Lighting_Data.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Lighting', createEmptyInstance: create)
    ..oo(0, [2, 3, 4])
    ..e<Mode>(1, _omitFieldNames ? '' : 'mode', $pb.PbFieldType.OE, defaultOrMaker: Mode.MODE_UNSPECIFIED, valueOf: Mode.valueOf, enumValues: Mode.values)
    ..aOM<TimePoints>(2, _omitFieldNames ? '' : 'schedule', subBuilder: TimePoints.create)
    ..aOM<Effect>(3, _omitFieldNames ? '' : 'effect', subBuilder: Effect.create)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'rgb', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Lighting clone() => Lighting()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Lighting copyWith(void Function(Lighting) updates) => super.copyWith((message) => updates(message as Lighting)) as Lighting;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Lighting create() => Lighting._();
  Lighting createEmptyInstance() => create();
  static $pb.PbList<Lighting> createRepeated() => $pb.PbList<Lighting>();
  @$core.pragma('dart2js:noInline')
  static Lighting getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Lighting>(create);
  static Lighting? _defaultInstance;

  Lighting_Data whichData() => _Lighting_DataByTag[$_whichOneof(0)]!;
  void clearData() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Mode get mode => $_getN(0);
  @$pb.TagNumber(1)
  set mode(Mode v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMode() => $_has(0);
  @$pb.TagNumber(1)
  void clearMode() => clearField(1);

  @$pb.TagNumber(2)
  TimePoints get schedule => $_getN(1);
  @$pb.TagNumber(2)
  set schedule(TimePoints v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasSchedule() => $_has(1);
  @$pb.TagNumber(2)
  void clearSchedule() => clearField(2);
  @$pb.TagNumber(2)
  TimePoints ensureSchedule() => $_ensure(1);

  @$pb.TagNumber(3)
  Effect get effect => $_getN(2);
  @$pb.TagNumber(3)
  set effect(Effect v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasEffect() => $_has(2);
  @$pb.TagNumber(3)
  void clearEffect() => clearField(3);
  @$pb.TagNumber(3)
  Effect ensureEffect() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.int get rgb => $_getIZ(3);
  @$pb.TagNumber(4)
  set rgb($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRgb() => $_has(3);
  @$pb.TagNumber(4)
  void clearRgb() => clearField(4);
}

class TimePoints extends $pb.GeneratedMessage {
  factory TimePoints() => create();
  TimePoints._() : super();
  factory TimePoints.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TimePoints.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TimePoints', createEmptyInstance: create)
    ..pc<TimePoint>(1, _omitFieldNames ? '' : 'points', $pb.PbFieldType.PM, subBuilder: TimePoint.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TimePoints clone() => TimePoints()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TimePoints copyWith(void Function(TimePoints) updates) => super.copyWith((message) => updates(message as TimePoints)) as TimePoints;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TimePoints create() => TimePoints._();
  TimePoints createEmptyInstance() => create();
  static $pb.PbList<TimePoints> createRepeated() => $pb.PbList<TimePoints>();
  @$core.pragma('dart2js:noInline')
  static TimePoints getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TimePoints>(create);
  static TimePoints? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TimePoint> get points => $_getList(0);
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

class TimePoint extends $pb.GeneratedMessage {
  factory TimePoint() => create();
  TimePoint._() : super();
  factory TimePoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TimePoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TimePoint', createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'hh', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'mm', $pb.PbFieldType.OU3)
    ..aOM<Brightness>(3, _omitFieldNames ? '' : 'brightness', subBuilder: Brightness.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TimePoint clone() => TimePoint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TimePoint copyWith(void Function(TimePoint) updates) => super.copyWith((message) => updates(message as TimePoint)) as TimePoint;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TimePoint create() => TimePoint._();
  TimePoint createEmptyInstance() => create();
  static $pb.PbList<TimePoint> createRepeated() => $pb.PbList<TimePoint>();
  @$core.pragma('dart2js:noInline')
  static TimePoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TimePoint>(create);
  static TimePoint? _defaultInstance;

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
  Brightness get brightness => $_getN(2);
  @$pb.TagNumber(3)
  set brightness(Brightness v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasBrightness() => $_has(2);
  @$pb.TagNumber(3)
  void clearBrightness() => clearField(3);
  @$pb.TagNumber(3)
  Brightness ensureBrightness() => $_ensure(2);
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
