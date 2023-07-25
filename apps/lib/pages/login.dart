import 'package:tidal_tech/styles/button.dart';
import 'package:tidal_tech/ui/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
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
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 414,
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
                  ..color = Colors.grey.shade100
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
                  ..bg = Colors.grey.shade100.withOpacity(0.5)
                  ..maxLines = 1
                  ..rounded = 12
                  ..fontSize = 14
                  ..noUnderline
                  ..color = Colors.grey.shade800
                  ..hintText = "Username"
                  ..textAlignVertical = TextAlignVertical.center
                  ..isCollapsed = true
                  ..prefixIcon = Icon(
                    Icons.person,
                    color: Colors.grey.shade800,
                  )
                  ..textInputAction = TextInputAction.next
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
                  ..textInputAction = TextInputAction.go
                  ..isCollapsed = true
                  ..textAlignVertical = TextAlignVertical.center
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
                      ))
                  ..onEditingComplete = () {
                    // hide keyboard
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                  ..bg = Colors.grey.shade100.withOpacity(0.5)
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
                      await ref.read(userProvider.notifier).login(
                            username: username.text,
                            password: password.text,
                          );

                      loading.value = false;
                      // show alert message
                      showTopSnackBar(
                        Overlay.of(context),
                        XSnackBar.success(
                          message:
                              "Good job, your release is successful. Have a nice day",
                        ),
                      );
                      context.go("/home");
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
                  ..color = Colors.grey.shade100,
                n.Box()
                  ..height = 100
                  ..bg = Colors.grey.shade200.withOpacity(0.5)
                  ..rounded = 16
                  ..width = 100,
                // sign in with google
              ])
                ..mainCenter
                ..crossCenter
                ..gap = 16
                ..px = 24
                ..py = 16,
            ),
          ),
        ),
      ),
    );
  }
}
