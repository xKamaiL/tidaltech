import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tidal_tech/models/devices.dart';
import 'package:tidal_tech/models/preset.dart';
import 'package:tidal_tech/models/user.dart';

import 'auth.dart';

part 'api.g.dart';

@JsonSerializable()
class APIEmpty {
  APIEmpty();

  factory APIEmpty.fromJson(Map<String, dynamic> json) =>
      _$APIEmptyFromJson(json);

  Map<String, dynamic> toJson() => _$APIEmptyToJson(this);
}

@JsonSerializable()
class APIError {
  final String? message;
  final String? code;
  @JsonKey(name: "items")
  List<String>? items = [];

  bool isValidate() {
    if (code == null) return false;
    return code == "VALIDATE_ERROR";
  }

  String errorMessage() {
    final x = message;
    if (x == null) {
      return "Internal Server Error";
    } else {
      if (isValidate()) {
        if (items == null) return "";
        return items!.join(" ");
      }
      return x;
    }
  }

  APIError({required this.message, required this.code});

  factory APIError.fromJson(Map<String, dynamic> json) =>
      _$APIErrorFromJson(json);

  Map<String, dynamic> toJson() => _$APIErrorToJson(this);
}

@JsonSerializable(
  genericArgumentFactories: true,
)
class APIFormat<T> {
  final T? result;
  final bool ok;
  final APIError? error;

  APIFormat({required this.result, required this.ok, required this.error});

  factory APIFormat.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$APIFormatFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(
    Object? Function(T value) toJsonT,
  ) =>
      _$APIFormatToJson(this, toJsonT);
}

@RestApi(baseUrl: "https://tidaltech.fly.dev")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("/auth.SignIn")
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "Accept": "application/json",
  })
  Future<APIFormat<TokenResult>> signIn(@Body() SignInParam param);

  @POST("/auth.Me")
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "Accept": "application/json",
  })
  Future<APIFormat<User>> me();

  @POST("/auth.SignUp")
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "Accept": "application/json",
  })
  Future<APIFormat<TokenResult>> signUp(@Body() SignUpParam param);

  @POST("/devices.Get")
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "Accept": "application/json",
  })
  Future<APIFormat<DeviceItem>> fetchDevice(@Body() PairParam param);

  @POST("/devices.UnPair")
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "Accept": "application/json",
  })
  Future<APIFormat> unPair(@Body() UnPairParam param);

  @POST("/devices.Pair")
  Future<APIFormat> pair(@Body() PairParam param);

  @POST("/devices.updateSchedule")
  Future<APIFormat> updateSchedule(@Body() UpdateScheduleParam param);

  @POST("/devices.setMode")
  Future<APIFormat> updateMode(@Body() UpdateModeParam param);

  @POST("/devices.updateStaticColor")
  Future<APIFormat> updateStaticColor(@Body() UpdateStaticColorParam param);

  @POST("/presets.List")
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "Accept": "application/json",
  })
  Future<APIFormat<MyPresetResult>> fetchMyPresets();

  @POST("/presets.Create")
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
    "Accept": "application/json",
  })
  Future createPreset(@Body() CreatePresetParam param);

  @POST("/presets.Delete")
  Future deletePreset(@Body() DeletePresetParam param);

//
}
