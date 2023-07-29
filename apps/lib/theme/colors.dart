import 'package:flutter/material.dart';

// tailwind colors
class ThemeColors {
  static const black = Color(0xFF000000);
  static const transparent = Colors.transparent;
  static const white = Color(0xFFFFFFFF);
  static const MaterialColor zinc = MaterialColor(0xFF71717a, <int, Color>{
    50: Color(0xFFfafafa),
    100: Color(0xFFf4f4f5),
    200: Color(0xFFe4e4e7),
    300: Color(0xFFd4d4d8),
    400: Color(0xFFa1a1aa),
    500: Color(0xFF71717a),
    600: Color(0xFF52525b), // #52525b
    700: Color(0xFF3f3f46), // #3f3f46
    800: Color(0xFF27272a),
    900: Color(0xFF18181b),
    950: Color(0xFF09090b),
  });
  static const foreground = Color(0xFF0f172a);
  static const muted = Color(0xFFf1f5f9);
  static const mutedForeground = Color(0xFF64748b);
  static const MaterialColor grey = MaterialColor(0xFF9ca3af, <int, Color>{
    50: Color(0xFFf9fafb),
    100: Color(0xFFf3f4f6),
    200: Color(0xFFe5e7eb),
    300: Color(0xFFd1d5db),
    400: Color(0xFF9ca3af),
    500: Color(0xFF6b7280),
    600: Color(0xFF4b5563),
    700: Color(0xFF374151),
    800: Color(0xFF1f2937),
    900: Color(0xFF111827),
  });
  static const MaterialColor primary = MaterialColor(0xFF6366f1, <int, Color>{
    50: Color(0xFFeef2ff),
    100: Color(0xFFe0e7ff),
    200: Color(0xFFc7d2fe),
    300: Color(0xFFa5b4fc),
    400: Color(0xFF818cf8),
    500: Color(0xFF6366f1),
    600: Color(0xFF4f46e5),
    700: Color(0xFF4338ca),
    800: Color(0xFF3730a3),
    900: Color(0xFF312e81),
    950: Color(0xFF1e1b4b),
  });

  static const danger = MaterialColor(0xFFef4444, <int, Color>{
    50: Color(0xFFfef2f2),
    100: Color(0xFFfee2e2),
    200: Color(0xFFfecaca),
    300: Color(0xFFfca5a5),
    400: Color(0xFFf87171),
    500: Color(0xFFef4444),
    600: Color(0xFFdc2626),
    700: Color(0xFFb91c1c),
    800: Color(0xFF991b1b),
    900: Color(0xFF7f1d1d),
  });
}
