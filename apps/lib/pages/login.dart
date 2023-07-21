import 'package:TidalTech/styles/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;

import '../stores/stores.dart';

class LoginPage extends HookConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final username = useTextEditingController();
    final password = useTextEditingController();

    final user = ref.watch(userProvider);

    return Scaffold(
      body: Form(
        key: _formKey,
        child: n.Column([
          "Sign in to Apps".h4
            ..bold
            ..justify
            ..mb = 16
            // make it center
            ..fullWidth
            ..center,
          n.TextFormField()
            ..controller = username
            ..isFilled
            ..bg = Colors.grey.shade100
            ..maxLines = 1
            ..rounded = 12
            ..noUnderline
            ..color = Colors.grey.shade900
            ..hintText = "Username"
            ..validator = (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          n.TextFormField()
            ..controller = password
            ..noUnderline
            ..isFilled
            ..rounded = 12
            ..bg = Colors.grey.shade100
            ..color = Colors.grey.shade900
            ..hintText = "Password"
            ..maxLines = 1
            ..asPassword
            ..validator = (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          n.Button("Sign in".n)
            ..fullWidth
            ..apply = XButtonStyle.confirm,
          const Divider(
            height: 0,
            thickness: 0.5,
            indent: 50,
            endIndent: 50,
          ),
          n.Text("Or sign in with")
            ..center
            ..fullWidth
            ..color = Colors.grey.shade900,
          // sign in with google
        ])
          ..mainCenter
          ..fullSize
          ..gap = 16
          ..px = 16
          ..crossStart,
      ),
    );
  }
}
