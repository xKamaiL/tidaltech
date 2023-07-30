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

class Mode extends $pb.ProtobufEnum {
  static const Mode MODE_UNSPECIFIED = Mode._(0, _omitEnumNames ? '' : 'MODE_UNSPECIFIED');
  static const Mode MODE_MANUAL = Mode._(1, _omitEnumNames ? '' : 'MODE_MANUAL');
  static const Mode MODE_SCHEDULE = Mode._(2, _omitEnumNames ? '' : 'MODE_SCHEDULE');
  static const Mode MODE_EFFECT = Mode._(3, _omitEnumNames ? '' : 'MODE_EFFECT');

  static const $core.List<Mode> values = <Mode> [
    MODE_UNSPECIFIED,
    MODE_MANUAL,
    MODE_SCHEDULE,
    MODE_EFFECT,
  ];

  static final $core.Map<$core.int, Mode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Mode? valueOf($core.int value) => _byValue[value];

  const Mode._($core.int v, $core.String n) : super(v, n);
}

class LED extends $pb.ProtobufEnum {
  static const LED LED_UNSPECIFIED = LED._(0, _omitEnumNames ? '' : 'LED_UNSPECIFIED');
  static const LED LED_WHITE = LED._(1, _omitEnumNames ? '' : 'LED_WHITE');
  static const LED LED_WARM_WHITE = LED._(2, _omitEnumNames ? '' : 'LED_WARM_WHITE');
  static const LED LED_RED = LED._(3, _omitEnumNames ? '' : 'LED_RED');
  static const LED LED_GREEN = LED._(4, _omitEnumNames ? '' : 'LED_GREEN');
  static const LED LED_BLUE = LED._(5, _omitEnumNames ? '' : 'LED_BLUE');
  static const LED LED_ROYAL_BLUE = LED._(6, _omitEnumNames ? '' : 'LED_ROYAL_BLUE');
  static const LED LED_ULTRA_VIOLET = LED._(7, _omitEnumNames ? '' : 'LED_ULTRA_VIOLET');

  static const $core.List<LED> values = <LED> [
    LED_UNSPECIFIED,
    LED_WHITE,
    LED_WARM_WHITE,
    LED_RED,
    LED_GREEN,
    LED_BLUE,
    LED_ROYAL_BLUE,
    LED_ULTRA_VIOLET,
  ];

  static final $core.Map<$core.int, LED> _byValue = $pb.ProtobufEnum.initByValue(values);
  static LED? valueOf($core.int value) => _byValue[value];

  const LED._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
