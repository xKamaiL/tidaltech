import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tidal_tech/models/auth.dart';
import 'package:tidal_tech/models/models.dart';
import 'package:uuid/uuid.dart';

class UserState {
  bool isLoggedIn = false;

  late User profile;
}

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier(super.state);

  void fetchMe() async {
    final res = await api.me();
    if (res.ok) {
      setUser(res.result!);
    }

    setSignOut();
  }

  void setSignOut() {
    state.isLoggedIn = false;
    state = state;
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
