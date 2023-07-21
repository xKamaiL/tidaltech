import 'package:TidalTech/styles/button.dart';
import 'package:TidalTech/ui/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../stores/stores.dart';

class LoginPage extends HookConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  // can you create password visible state ?

  LoginPage({Key? key}) : super(key: key);

  void togglePassword() {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isShowPassword = useState(false);
    final loading = useState(false);
    final username = useTextEditingController();
    final password = useTextEditingController();

    final user = ref.watch(userProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: n.Column([
              n.Box()..height = 32,
              n.Image.network("https://placehold.co/100x100/png")
                ..cover
                ..width = 100
                ..height = 100
                ..rounded = 10
                ..useCircleProgress(
                  color: Colors.indigo.shade100,
                ),
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
                ..scrollPhysics = const NeverScrollableScrollPhysics()
                ..scrollPadding = EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom - 16 * 4)
                ..bg = Colors.grey.shade100
                ..maxLines = 1
                ..rounded = 12
                ..fontSize = 14
                ..noUnderline
                ..color = Colors.grey.shade800
                ..hintText = "Username"
                ..useDecoration(
                  (p0) => p0
                    ..prefixIcon = Icon(
                      Icons.person,
                      color: Colors.grey.shade800,
                    ),
                )
                ..validator = (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter username';
                  }
                  if (value.length < 3) {
                    return 'Username must be at least 3 characters long';
                  }
                  return null;
                },
              n.TextFormField()
                ..controller = password
                ..noUnderline
                ..isFilled
                ..scrollPhysics = const NeverScrollableScrollPhysics()
                ..scrollPadding = EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom - 16 * 4)
                ..rounded = 12
                ..fontSize = 14
                ..useDecoration(
                  (p0) => p0
                    ..prefixIcon = Icon(
                      Icons.lock,
                      color: Colors.grey.shade800,
                    )
                    ..suffixIcon = IconButton(
                        onPressed: () => {
                              isShowPassword.value = !isShowPassword.value,
                            },
                        icon: Icon(
                          Icons.visibility,
                          color: Colors.grey.shade800,
                        )),
                )
                ..bg = Colors.grey.shade100
                ..color = Colors.grey.shade900
                ..hintText = "Password"
                ..maxLines = 1
                ..asPassword = !isShowPassword.value
                ..validator = (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              n.Button("Sign In".n)
                ..apply = XButtonStyle.confirm(
                  loading: loading.value,
                  label: "Sign In",
                )
                ..onPressed = () async {
                  if (loading.value) return;
                  if (_formKey.currentState!.validate()) {
                    FocusManager.instance.primaryFocus?.unfocus();

                    loading.value = true;
                    await Future.delayed(const Duration(seconds: 2));
                    loading.value = false;
                    // show alert message
                    showTopSnackBar(
                      Overlay.of(context),
                      XSnackBar.success(
                        message:
                            "Good job, your release is successful. Have a nice day",
                      ),
                    );
                  }
                }
                ..fullWidth,
              const Divider(
                height: 0,
                thickness: 0.5,
                indent: 50,
                endIndent: 50,
              ),
              n.Text("Or sign in with")
                ..center
                ..fullWidth
                ..fontSize = 14
                ..color = Colors.grey.shade900,
              n.Box()
                ..height = 100
                ..bg = Colors.grey.shade200
                ..rounded = 16
                ..width = 100,
              // sign in with google
            ])
              ..mainCenter
              ..crossCenter
              ..gap = 16
              ..p = 16,
          ),
        ),
      ),
    );
  }
}
