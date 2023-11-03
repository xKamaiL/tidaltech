// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenResult _$TokenResultFromJson(Map<String, dynamic> json) => TokenResult(
      token: json['token'] as String,
    );

Map<String, dynamic> _$TokenResultToJson(TokenResult instance) =>
    <String, dynamic>{
      'token': instance.token,
    };

SignInParam _$SignInParamFromJson(Map<String, dynamic> json) => SignInParam(
      username: json['username'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SignInParamToJson(SignInParam instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

SignUpParam _$SignUpParamFromJson(Map<String, dynamic> json) => SignUpParam(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SignUpParamToJson(SignUpParam instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
