import 'package:dio/dio.dart';
import 'package:tidal_tech/models/token.dart';
import 'api.dart';

export 'user.dart';

final api = RestClient(Dio()..interceptors.add(TokenInterceptor()));
