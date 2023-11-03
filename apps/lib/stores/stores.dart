import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tidal_tech/models/auth.dart';
import 'package:tidal_tech/models/models.dart';
import 'package:uuid/uuid.dart';

class UserState {
  bool isFistLoad = true;
  bool isLoggedIn = false;

  late User profile;
}

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier(super.state);

  Future<void> fetchMe() async {
    state.isFistLoad = false;
    state = state;
    final res = await api.me();
    if (res.ok) {
      setUser(res.result!);
      return;
    }

    signOut();
  }

  void signOut() {
    state.isLoggedIn = false;
    state = state;
    SharedPreferences.getInstance().then((value) {
      value.remove("token");
    });
  }

  void setUser(User user) {
    state.isLoggedIn = true;
    state.profile = user;
    state = state;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier(UserState());
});
