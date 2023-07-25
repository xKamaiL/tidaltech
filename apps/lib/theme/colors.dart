import 'package:flutter/material.dart';

// tailwind colors
class ThemeColors {
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
  static const MaterialColor primary = MaterialColor(0xFF3b82f6, <int, Color>{
    50: Color(0xFFeff6ff),
    100: Color(0xFFdbeafe),
    200: Color(0xFFbfdbfe),
    300: Color(0xFF93c5fd),
    400: Color(0xFF60a5fa),
    500: Color(0xFF3b82f6),
    600: Color(0xFF2563eb),
    700: Color(0xFF1d4ed8),
    800: Color(0xFF1e40af),
    900: Color(0xFF1e3a8a),
  });
}
