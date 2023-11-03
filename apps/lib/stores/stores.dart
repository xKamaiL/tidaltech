import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tidal_tech/models/auth.dart';
import 'package:tidal_tech/models/models.dart';

@immutable
class User {
  const User(this.email, this.name, this.photoUrl, {required this.id});

  final String id;
  final String email;
  final String name;
  final String? photoUrl;

  final isLoading = false;
}

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  void setUser(User user) {
    state = user;
  }

  void clearUser() {
    state = null;
  }

  get isLogin => state != null;



  Future<void> fetchUser() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(seconds: 2));
    clearUser();
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier();
});
