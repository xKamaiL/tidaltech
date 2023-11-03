import 'package:shared_preferences/shared_preferences.dart';
import 'package:tidal_tech/stores/bottom_bar.dart';
import 'package:tidal_tech/styles/button.dart';
import 'package:tidal_tech/theme/colors.dart';
import 'package:tidal_tech/ui/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:niku/namespace.dart' as n;
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../models/auth.dart';
import '../models/models.dart';
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
    final email = useTextEditingController();
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
                n.Image(
                  const ExactAssetImage("assets/icon/icon_transparent.png"),
                )
                  ..cover
                  ..width = 150
                  ..height = 150
                  ..rounded = 10
                  ..useCircleProgress(
                    color: ThemeColors.foreground,
                  ),
                n.RichText(
                  n.TextSpan("Tidal Tech")
                    ..color = ThemeColors.primary
                    ..fontSize = 32
                    ..fontFamily = "NotoSansThai_regular"
                    ..fontWeight = FontWeight.w600,
                )
                  ..wFull
                  ..mb = 24
                  ..center,
                n.TextFormField()
                  ..controller = email
                  ..isFilled
                  ..scrollPhysics = const NeverScrollableScrollPhysics()
                  ..scrollPadding = EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom - 16 * 4)
                  ..maxLines = 1
                  ..rounded = 12
                  ..fontSize = 14
                  ..noUnderline
                  ..bg = ThemeColors.zinc.shade100
                  ..color = ThemeColors.foreground
                  ..hintText = "Email Address"
                  ..textAlignVertical = TextAlignVertical.center
                  ..isCollapsed = true
                  ..prefixIcon = const Icon(
                    Icons.person,
                    color: ThemeColors.foreground,
                  )
                  ..textInputAction = TextInputAction.next
                  ..validator = (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    if (value.length < 3) {
                      return 'Email must be at least 3 characters long';
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
                  ..prefixIcon = const Icon(
                    Icons.lock,
                    color: ThemeColors.foreground,
                  )
                  ..suffixIcon = IconButton(
                      onPressed: () => {
                            isShowPassword.value = !isShowPassword.value,
                          },
                      splashRadius: 20,
                      icon: const Icon(
                        Icons.visibility,
                        color: ThemeColors.foreground,
                      ))
                  ..onEditingComplete = () {
                    // hide keyboard
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                  ..bg = ThemeColors.zinc.shade100
                  ..color = ThemeColors.foreground
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
                      final res = await api.signIn(SignInParam(
                          email: email.value.text,
                          password: password.value.text));

                      loading.value = false;
                      // show alert message
                      if (!res.ok) {
                        showTopSnackBar(
                          Overlay.of(context),
                          XSnackBar.error(
                            message: res.error!.errorMessage(),
                          ),
                        );
                        return;
                      }

                      final prefs = await SharedPreferences.getInstance();
                      prefs.setString("token", res.result!.token);

                      final meResult = await api.me();

                      if (!meResult.ok) {
                        return;
                      }

                      ref.read(userProvider.notifier).setUser(
                            meResult.result!,
                          );

                      ref.read(bottomBarProvider.notifier).setPosition(0);
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
                n.Column([
                  n.Text("Don't have any account?")
                    ..center
                    ..fullWidth
                    ..fontSize = 14,
                  n.Button("Sign Up".n)
                    ..onPressed = () {
                      //
                      context.go("/sign-up");
                    },
                ]),
                n.Box()
                  ..height = 100
                  ..bg = ThemeColors.zinc.shade100
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
