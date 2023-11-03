import 'dart:convert';

import 'package:dio/dio.dart' hide Headers;
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tidal_tech/models/user.dart';

import 'auth.dart';

part 'api.g.dart';

@JsonSerializable()
class APIError {
  final String? message;
  final String? code;

  String errorMessage() {
    final x = message;
    if (x == null) {
      return "Internal Server Error";
    } else {
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
  final APIError error;

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
  Future<APIFormat<User>> me();

  @POST("/auth.SignUp")
  Future<APIFormat<TokenResult>> signUp(@Body() SignUpParam param);

//
}
