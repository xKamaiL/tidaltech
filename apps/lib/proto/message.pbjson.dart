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

@$core.Deprecated('Use modeDescriptor instead')
const Mode$json = {
  '1': 'Mode',
  '2': [
    {'1': 'MODE_UNSPECIFIED', '2': 0},
    {'1': 'MODE_MANUAL', '2': 1},
    {'1': 'MODE_SCHEDULE', '2': 2},
    {'1': 'MODE_EFFECT', '2': 3},
  ],
};

/// Descriptor for `Mode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List modeDescriptor = $convert.base64Decode(
    'CgRNb2RlEhQKEE1PREVfVU5TUEVDSUZJRUQQABIPCgtNT0RFX01BTlVBTBABEhEKDU1PREVfU0'
    'NIRURVTEUQAhIPCgtNT0RFX0VGRkVDVBAD');

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

@$core.Deprecated('Use lightingDescriptor instead')
const Lighting$json = {
  '1': 'Lighting',
  '2': [
    {'1': 'mode', '3': 1, '4': 1, '5': 14, '6': '.Mode', '10': 'mode'},
    {'1': 'schedule', '3': 2, '4': 1, '5': 11, '6': '.TimePoints', '9': 0, '10': 'schedule'},
    {'1': 'effect', '3': 3, '4': 1, '5': 11, '6': '.Effect', '9': 0, '10': 'effect'},
    {'1': 'rgb', '3': 4, '4': 1, '5': 13, '9': 0, '10': 'rgb'},
  ],
  '8': [
    {'1': 'data'},
  ],
};

/// Descriptor for `Lighting`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lightingDescriptor = $convert.base64Decode(
    'CghMaWdodGluZxIZCgRtb2RlGAEgASgOMgUuTW9kZVIEbW9kZRIpCghzY2hlZHVsZRgCIAEoCz'
    'ILLlRpbWVQb2ludHNIAFIIc2NoZWR1bGUSIQoGZWZmZWN0GAMgASgLMgcuRWZmZWN0SABSBmVm'
    'ZmVjdBISCgNyZ2IYBCABKA1IAFIDcmdiQgYKBGRhdGE=');

@$core.Deprecated('Use timePointsDescriptor instead')
const TimePoints$json = {
  '1': 'TimePoints',
  '2': [
    {'1': 'points', '3': 1, '4': 3, '5': 11, '6': '.TimePoint', '10': 'points'},
  ],
};

/// Descriptor for `TimePoints`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timePointsDescriptor = $convert.base64Decode(
    'CgpUaW1lUG9pbnRzEiIKBnBvaW50cxgBIAMoCzIKLlRpbWVQb2ludFIGcG9pbnRz');

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

@$core.Deprecated('Use timePointDescriptor instead')
const TimePoint$json = {
  '1': 'TimePoint',
  '2': [
    {'1': 'hh', '3': 1, '4': 1, '5': 13, '10': 'hh'},
    {'1': 'mm', '3': 2, '4': 1, '5': 13, '10': 'mm'},
    {'1': 'brightness', '3': 3, '4': 1, '5': 11, '6': '.Brightness', '10': 'brightness'},
  ],
};

/// Descriptor for `TimePoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timePointDescriptor = $convert.base64Decode(
    'CglUaW1lUG9pbnQSDgoCaGgYASABKA1SAmhoEg4KAm1tGAIgASgNUgJtbRIrCgpicmlnaHRuZX'
    'NzGAMgASgLMgsuQnJpZ2h0bmVzc1IKYnJpZ2h0bmVzcw==');

@$core.Deprecated('Use brightnessDescriptor instead')
const Brightness$json = {
  '1': 'Brightness',
  '2': [
    {'1': 'white', '3': 3, '4': 1, '5': 13, '10': 'white'},
    {'1': 'warm_white', '3': 4, '4': 1, '5': 13, '10': 'warmWhite'},
    {'1': 'red', '3': 5, '4': 1, '5': 13, '10': 'red'},
    {'1': 'green', '3': 6, '4': 1, '5': 13, '10': 'green'},
    {'1': 'blue', '3': 7, '4': 1, '5': 13, '10': 'blue'},
    {'1': 'royal_blue', '3': 8, '4': 1, '5': 13, '10': 'royalBlue'},
    {'1': 'ultra_violet', '3': 9, '4': 1, '5': 13, '10': 'ultraViolet'},
  ],
};

/// Descriptor for `Brightness`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List brightnessDescriptor = $convert.base64Decode(
    'CgpCcmlnaHRuZXNzEhQKBXdoaXRlGAMgASgNUgV3aGl0ZRIdCgp3YXJtX3doaXRlGAQgASgNUg'
    'l3YXJtV2hpdGUSEAoDcmVkGAUgASgNUgNyZWQSFAoFZ3JlZW4YBiABKA1SBWdyZWVuEhIKBGJs'
    'dWUYByABKA1SBGJsdWUSHQoKcm95YWxfYmx1ZRgIIAEoDVIJcm95YWxCbHVlEiEKDHVsdHJhX3'
    'Zpb2xldBgJIAEoDVILdWx0cmFWaW9sZXQ=');

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

