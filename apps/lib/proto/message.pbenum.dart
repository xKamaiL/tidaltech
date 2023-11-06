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

class Scene extends $pb.ProtobufEnum {
  static const Scene SCENE_UNSPECIFIED = Scene._(0, _omitEnumNames ? '' : 'SCENE_UNSPECIFIED');

  static const $core.List<Scene> values = <Scene> [
    SCENE_UNSPECIFIED,
  ];

  static final $core.Map<$core.int, Scene> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Scene? valueOf($core.int value) => _byValue[value];

  const Scene._($core.int v, $core.String n) : super(v, n);
}

class CommandCode extends $pb.ProtobufEnum {
  static const CommandCode COMMAND_CODE_UNSPECIFIED = CommandCode._(0, _omitEnumNames ? '' : 'COMMAND_CODE_UNSPECIFIED');
  static const CommandCode COMMAND_CODE_GET_PROPERTIES = CommandCode._(1, _omitEnumNames ? '' : 'COMMAND_CODE_GET_PROPERTIES');
  static const CommandCode COMMAND_CODE_SET_LIGHTING = CommandCode._(5, _omitEnumNames ? '' : 'COMMAND_CODE_SET_LIGHTING');
  static const CommandCode COMMAND_CODE_UPGRADE_FIRMWARE = CommandCode._(6, _omitEnumNames ? '' : 'COMMAND_CODE_UPGRADE_FIRMWARE');

  static const $core.List<CommandCode> values = <CommandCode> [
    COMMAND_CODE_UNSPECIFIED,
    COMMAND_CODE_GET_PROPERTIES,
    COMMAND_CODE_SET_LIGHTING,
    COMMAND_CODE_UPGRADE_FIRMWARE,
  ];

  static final $core.Map<$core.int, CommandCode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CommandCode? valueOf($core.int value) => _byValue[value];

  const CommandCode._($core.int v, $core.String n) : super(v, n);
}

class Mode extends $pb.ProtobufEnum {
  static const Mode MODE_UNSPECIFIED = Mode._(0, _omitEnumNames ? '' : 'MODE_UNSPECIFIED');
  static const Mode MODE_MANUAL = Mode._(1, _omitEnumNames ? '' : 'MODE_MANUAL');
  static const Mode MODE_SCHEDULE = Mode._(2, _omitEnumNames ? '' : 'MODE_SCHEDULE');

  static const $core.List<Mode> values = <Mode> [
    MODE_UNSPECIFIED,
    MODE_MANUAL,
    MODE_SCHEDULE,
  ];

  static final $core.Map<$core.int, Mode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Mode? valueOf($core.int value) => _byValue[value];

  const Mode._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
