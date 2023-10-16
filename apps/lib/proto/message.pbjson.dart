//
//  Generated code. Do not modify.
//  source: proto/message.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use sceneDescriptor instead')
const Scene$json = {
  '1': 'Scene',
  '2': [
    {'1': 'SCENE_UNSPECIFIED', '2': 0},
  ],
};

/// Descriptor for `Scene`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List sceneDescriptor = $convert.base64Decode(
    'CgVTY2VuZRIVChFTQ0VORV9VTlNQRUNJRklFRBAA');

@$core.Deprecated('Use commandCodeDescriptor instead')
const CommandCode$json = {
  '1': 'CommandCode',
  '2': [
    {'1': 'COMMAND_CODE_UNSPECIFIED', '2': 0},
    {'1': 'COMMAND_CODE_GET_PROPERTIES', '2': 1},
    {'1': 'COMMAND_CODE_SET_LIGHTING', '2': 5},
    {'1': 'COMMAND_CODE_UPGRADE_FIRMWARE', '2': 6},
  ],
};

/// Descriptor for `CommandCode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List commandCodeDescriptor = $convert.base64Decode(
    'CgtDb21tYW5kQ29kZRIcChhDT01NQU5EX0NPREVfVU5TUEVDSUZJRUQQABIfChtDT01NQU5EX0'
    'NPREVfR0VUX1BST1BFUlRJRVMQARIdChlDT01NQU5EX0NPREVfU0VUX0xJR0hUSU5HEAUSIQod'
    'Q09NTUFORF9DT0RFX1VQR1JBREVfRklSTVdBUkUQBg==');

@$core.Deprecated('Use modeDescriptor instead')
const Mode$json = {
  '1': 'Mode',
  '2': [
    {'1': 'MODE_UNSPECIFIED', '2': 0},
    {'1': 'MODE_MANUAL', '2': 1},
    {'1': 'MODE_SCHEDULE', '2': 2},
  ],
};

/// Descriptor for `Mode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List modeDescriptor = $convert.base64Decode(
    'CgRNb2RlEhQKEE1PREVfVU5TUEVDSUZJRUQQABIPCgtNT0RFX01BTlVBTBABEhEKDU1PREVfU0'
    'NIRURVTEUQAg==');

@$core.Deprecated('Use lEDDescriptor instead')
const LED$json = {
  '1': 'LED',
  '2': [
    {'1': 'LED_UNSPECIFIED', '2': 0},
    {'1': 'LED_WHITE', '2': 1},
    {'1': 'LED_WARM_WHITE', '2': 2},
    {'1': 'LED_RED', '2': 3},
    {'1': 'LED_GREEN', '2': 4},
    {'1': 'LED_BLUE', '2': 5},
    {'1': 'LED_ROYAL_BLUE', '2': 6},
    {'1': 'LED_ULTRA_VIOLET', '2': 7},
  ],
};

/// Descriptor for `LED`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List lEDDescriptor = $convert.base64Decode(
    'CgNMRUQSEwoPTEVEX1VOU1BFQ0lGSUVEEAASDQoJTEVEX1dISVRFEAESEgoOTEVEX1dBUk1fV0'
    'hJVEUQAhILCgdMRURfUkVEEAMSDQoJTEVEX0dSRUVOEAQSDAoITEVEX0JMVUUQBRISCg5MRURf'
    'Uk9ZQUxfQkxVRRAGEhQKEExFRF9VTFRSQV9WSU9MRVQQBw==');

@$core.Deprecated('Use deviceInformationRequestDescriptor instead')
const DeviceInformationRequest$json = {
  '1': 'DeviceInformationRequest',
};

/// Descriptor for `DeviceInformationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceInformationRequestDescriptor = $convert.base64Decode(
    'ChhEZXZpY2VJbmZvcm1hdGlvblJlcXVlc3Q=');

@$core.Deprecated('Use deviceInformationResponseDescriptor instead')
const DeviceInformationResponse$json = {
  '1': 'DeviceInformationResponse',
  '2': [
    {'1': 'mode', '3': 1, '4': 1, '5': 14, '6': '.Mode', '10': 'mode'},
    {'1': 'current_timestamps', '3': 2, '4': 1, '5': 13, '10': 'currentTimestamps'},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    {'1': 'id', '3': 4, '4': 1, '5': 9, '10': 'id'},
    {'1': 'version', '3': 5, '4': 1, '5': 9, '10': 'version'},
  ],
};

/// Descriptor for `DeviceInformationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceInformationResponseDescriptor = $convert.base64Decode(
    'ChlEZXZpY2VJbmZvcm1hdGlvblJlc3BvbnNlEhkKBG1vZGUYASABKA4yBS5Nb2RlUgRtb2RlEi'
    '0KEmN1cnJlbnRfdGltZXN0YW1wcxgCIAEoDVIRY3VycmVudFRpbWVzdGFtcHMSEgoEbmFtZRgD'
    'IAEoCVIEbmFtZRIOCgJpZBgEIAEoCVICaWQSGAoHdmVyc2lvbhgFIAEoCVIHdmVyc2lvbg==');

@$core.Deprecated('Use lightingScheduleRequestDescriptor instead')
const LightingScheduleRequest$json = {
  '1': 'LightingScheduleRequest',
  '2': [
    {'1': 'points', '3': 1, '4': 3, '5': 11, '6': '.TimePointItem', '10': 'points'},
  ],
};

/// Descriptor for `LightingScheduleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lightingScheduleRequestDescriptor = $convert.base64Decode(
    'ChdMaWdodGluZ1NjaGVkdWxlUmVxdWVzdBImCgZwb2ludHMYASADKAsyDi5UaW1lUG9pbnRJdG'
    'VtUgZwb2ludHM=');

@$core.Deprecated('Use setSceneRequestDescriptor instead')
const SetSceneRequest$json = {
  '1': 'SetSceneRequest',
  '2': [
    {'1': 'scene', '3': 1, '4': 1, '5': 14, '6': '.Scene', '10': 'scene'},
  ],
};

/// Descriptor for `SetSceneRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setSceneRequestDescriptor = $convert.base64Decode(
    'Cg9TZXRTY2VuZVJlcXVlc3QSHAoFc2NlbmUYASABKA4yBi5TY2VuZVIFc2NlbmU=');

@$core.Deprecated('Use getSceneResponseDescriptor instead')
const GetSceneResponse$json = {
  '1': 'GetSceneResponse',
  '2': [
    {'1': 'scene', '3': 1, '4': 1, '5': 14, '6': '.Scene', '10': 'scene'},
  ],
};

/// Descriptor for `GetSceneResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSceneResponseDescriptor = $convert.base64Decode(
    'ChBHZXRTY2VuZVJlc3BvbnNlEhwKBXNjZW5lGAEgASgOMgYuU2NlbmVSBXNjZW5l');

@$core.Deprecated('Use effectDescriptor instead')
const Effect$json = {
  '1': 'Effect',
  '2': [
    {'1': 'duration', '3': 1, '4': 1, '5': 13, '10': 'duration'},
    {'1': 'timestamps', '3': 2, '4': 3, '5': 11, '6': '.TimeStamp', '10': 'timestamps'},
  ],
};

/// Descriptor for `Effect`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List effectDescriptor = $convert.base64Decode(
    'CgZFZmZlY3QSGgoIZHVyYXRpb24YASABKA1SCGR1cmF0aW9uEioKCnRpbWVzdGFtcHMYAiADKA'
    'syCi5UaW1lU3RhbXBSCnRpbWVzdGFtcHM=');

@$core.Deprecated('Use upgradeFirmwareRequestDescriptor instead')
const UpgradeFirmwareRequest$json = {
  '1': 'UpgradeFirmwareRequest',
};

/// Descriptor for `UpgradeFirmwareRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List upgradeFirmwareRequestDescriptor = $convert.base64Decode(
    'ChZVcGdyYWRlRmlybXdhcmVSZXF1ZXN0');

@$core.Deprecated('Use upgradeFirmwareResponseDescriptor instead')
const UpgradeFirmwareResponse$json = {
  '1': 'UpgradeFirmwareResponse',
  '2': [
    {'1': 'is_latest_version', '3': 1, '4': 1, '5': 8, '10': 'isLatestVersion'},
    {'1': 'current_version', '3': 2, '4': 1, '5': 9, '10': 'currentVersion'},
  ],
};

/// Descriptor for `UpgradeFirmwareResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List upgradeFirmwareResponseDescriptor = $convert.base64Decode(
    'ChdVcGdyYWRlRmlybXdhcmVSZXNwb25zZRIqChFpc19sYXRlc3RfdmVyc2lvbhgBIAEoCFIPaX'
    'NMYXRlc3RWZXJzaW9uEicKD2N1cnJlbnRfdmVyc2lvbhgCIAEoCVIOY3VycmVudFZlcnNpb24=');

@$core.Deprecated('Use timePointItemDescriptor instead')
const TimePointItem$json = {
  '1': 'TimePointItem',
  '2': [
    {'1': 'hh', '3': 1, '4': 1, '5': 13, '10': 'hh'},
    {'1': 'mm', '3': 2, '4': 1, '5': 13, '10': 'mm'},
    {'1': 'white', '3': 3, '4': 1, '5': 13, '9': 0, '10': 'white', '17': true},
    {'1': 'warm_white', '3': 4, '4': 1, '5': 13, '9': 1, '10': 'warmWhite', '17': true},
    {'1': 'red', '3': 5, '4': 1, '5': 13, '9': 2, '10': 'red', '17': true},
    {'1': 'green', '3': 6, '4': 1, '5': 13, '9': 3, '10': 'green', '17': true},
    {'1': 'blue', '3': 7, '4': 1, '5': 13, '9': 4, '10': 'blue', '17': true},
    {'1': 'royal_blue', '3': 8, '4': 1, '5': 13, '9': 5, '10': 'royalBlue', '17': true},
    {'1': 'ultra_violet', '3': 9, '4': 1, '5': 13, '9': 6, '10': 'ultraViolet', '17': true},
  ],
  '8': [
    {'1': '_white'},
    {'1': '_warm_white'},
    {'1': '_red'},
    {'1': '_green'},
    {'1': '_blue'},
    {'1': '_royal_blue'},
    {'1': '_ultra_violet'},
  ],
};

/// Descriptor for `TimePointItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timePointItemDescriptor = $convert.base64Decode(
    'Cg1UaW1lUG9pbnRJdGVtEg4KAmhoGAEgASgNUgJoaBIOCgJtbRgCIAEoDVICbW0SGQoFd2hpdG'
    'UYAyABKA1IAFIFd2hpdGWIAQESIgoKd2FybV93aGl0ZRgEIAEoDUgBUgl3YXJtV2hpdGWIAQES'
    'FQoDcmVkGAUgASgNSAJSA3JlZIgBARIZCgVncmVlbhgGIAEoDUgDUgVncmVlbogBARIXCgRibH'
    'VlGAcgASgNSARSBGJsdWWIAQESIgoKcm95YWxfYmx1ZRgIIAEoDUgFUglyb3lhbEJsdWWIAQES'
    'JgoMdWx0cmFfdmlvbGV0GAkgASgNSAZSC3VsdHJhVmlvbGV0iAEBQggKBl93aGl0ZUINCgtfd2'
    'FybV93aGl0ZUIGCgRfcmVkQggKBl9ncmVlbkIHCgVfYmx1ZUINCgtfcm95YWxfYmx1ZUIPCg1f'
    'dWx0cmFfdmlvbGV0');

@$core.Deprecated('Use brightnessDescriptor instead')
const Brightness$json = {
  '1': 'Brightness',
  '2': [
    {'1': 'white', '3': 3, '4': 1, '5': 13, '9': 0, '10': 'white', '17': true},
    {'1': 'warm_white', '3': 4, '4': 1, '5': 13, '9': 1, '10': 'warmWhite', '17': true},
    {'1': 'red', '3': 5, '4': 1, '5': 13, '9': 2, '10': 'red', '17': true},
    {'1': 'green', '3': 6, '4': 1, '5': 13, '9': 3, '10': 'green', '17': true},
    {'1': 'blue', '3': 7, '4': 1, '5': 13, '9': 4, '10': 'blue', '17': true},
    {'1': 'royal_blue', '3': 8, '4': 1, '5': 13, '9': 5, '10': 'royalBlue', '17': true},
    {'1': 'ultra_violet', '3': 9, '4': 1, '5': 13, '9': 6, '10': 'ultraViolet', '17': true},
  ],
  '8': [
    {'1': '_white'},
    {'1': '_warm_white'},
    {'1': '_red'},
    {'1': '_green'},
    {'1': '_blue'},
    {'1': '_royal_blue'},
    {'1': '_ultra_violet'},
  ],
};

/// Descriptor for `Brightness`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List brightnessDescriptor = $convert.base64Decode(
    'CgpCcmlnaHRuZXNzEhkKBXdoaXRlGAMgASgNSABSBXdoaXRliAEBEiIKCndhcm1fd2hpdGUYBC'
    'ABKA1IAVIJd2FybVdoaXRliAEBEhUKA3JlZBgFIAEoDUgCUgNyZWSIAQESGQoFZ3JlZW4YBiAB'
    'KA1IA1IFZ3JlZW6IAQESFwoEYmx1ZRgHIAEoDUgEUgRibHVliAEBEiIKCnJveWFsX2JsdWUYCC'
    'ABKA1IBVIJcm95YWxCbHVliAEBEiYKDHVsdHJhX3Zpb2xldBgJIAEoDUgGUgt1bHRyYVZpb2xl'
    'dIgBAUIICgZfd2hpdGVCDQoLX3dhcm1fd2hpdGVCBgoEX3JlZEIICgZfZ3JlZW5CBwoFX2JsdW'
    'VCDQoLX3JveWFsX2JsdWVCDwoNX3VsdHJhX3Zpb2xldA==');

@$core.Deprecated('Use timeStampDescriptor instead')
const TimeStamp$json = {
  '1': 'TimeStamp',
  '2': [
    {'1': 'seconds', '3': 1, '4': 1, '5': 13, '10': 'seconds'},
    {'1': 'brightness', '3': 2, '4': 1, '5': 11, '6': '.Brightness', '10': 'brightness'},
  ],
};

/// Descriptor for `TimeStamp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timeStampDescriptor = $convert.base64Decode(
    'CglUaW1lU3RhbXASGAoHc2Vjb25kcxgBIAEoDVIHc2Vjb25kcxIrCgpicmlnaHRuZXNzGAIgAS'
    'gLMgsuQnJpZ2h0bmVzc1IKYnJpZ2h0bmVzcw==');

