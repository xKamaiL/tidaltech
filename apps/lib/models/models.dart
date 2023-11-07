import 'package:dio/dio.dart';
import 'package:tidal_tech/models/token.dart';
import 'api.dart';

export 'user.dart';
export 'devices.dart';
export 'preset.dart';
export 'token.dart';
export 'scenes.dart';
export 'api.dart';

final api = RestClient(
  Dio()
    ..options = BaseOptions(
      baseUrl: "https://api.tidaltech.io",
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    )
    ..interceptors.add(TokenInterceptor()),
);
