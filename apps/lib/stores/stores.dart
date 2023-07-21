import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

@immutable
class User {
  const User(this.email, this.name, this.photoUrl, {required this.id});

  final String id;
  final String email;
  final String name;
  final String? photoUrl;
}

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  void setUser(User user) {
    state = user;
  }

  void clearUser() {
    state = null;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier();
});
