import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const IS_AUTHENTICATED_KEY = "IS_AUTHENTICATED_KEY";

final sharedPrefProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});
