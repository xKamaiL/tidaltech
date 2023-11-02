import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

@JsonSerializable()
class TokenResult {
  final String token;

  TokenResult({required this.token});

  factory TokenResult.fromJson(Map<String, dynamic> json) =>
      _$TokenResultFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResultToJson(this);
}

@JsonSerializable()
class SignInParam {
  String email;
  String password;

  SignInParam({required this.email, required this.password});

  factory SignInParam.fromJson(Map<String, dynamic> json) =>
      _$SignInParamFromJson(json);

  Map<String, dynamic> toJson() => _$SignInParamToJson(this);
}

@JsonSerializable()
class SignUpParam {
  String email;
  String password;

  SignUpParam({required this.email, required this.password});

  factory SignUpParam.fromJson(Map<String, dynamic> json) =>
      _$SignUpParamFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpParamToJson(this);
}
