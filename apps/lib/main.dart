import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tidal_tech/providers/router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tidal_tech/theme/colors.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    const ProviderScope(
      overrides: [],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Tidal Tech',
      theme: ThemeData(
        primarySwatch: ThemeColors.primary,
        fontFamily: GoogleFonts.notoSansThai().fontFamily,
        fontFamilyFallback: const ["NotoSansThai_regular", "sans-serif"],
        scaffoldBackgroundColor: ThemeColors.white,
        appBarTheme: Theme.of(context)
            .appBarTheme
            .copyWith(systemOverlayStyle: SystemUiOverlayStyle.light),
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
    );
  }
}
