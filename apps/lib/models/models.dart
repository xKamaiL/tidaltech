import 'package:dio/dio.dart';
import 'api.dart';

export 'user.dart';

final api = RestClient(Dio([
  BaseOptions(
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ),
] as BaseOptions?));
