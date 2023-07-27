import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tidal_tech/providers/router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tidal_tech/theme/colors.dart';

void main() async {
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
        fontFamilyFallback: ["NotoSansThai_regular", "sans-serif"],
        scaffoldBackgroundColor: ThemeColors.white,
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
    );
  }
}
