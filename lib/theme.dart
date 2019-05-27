import 'package:flutter/material.dart';

class ThemeColors {
  static final MaterialColor primary = MaterialColor(
    0xFF006996,
    const <int, Color> {
      50:  const Color(0xFF006996),
      100: const Color(0xFF006996),
      200: const Color(0xFF006996),
      300: const Color(0xFF006996),
      400: const Color(0xFF006996),
      500: const Color(0xFF006996),
      600: const Color(0xFF006996),
      700: const Color(0xFF006996),
      800: const Color(0xFF006996),
      900: const Color(0xFF006996),
    },
  );
}

final themeData = ThemeData(
  // This is the theme of your application.
  primaryColor: ThemeColors.primary,
  primarySwatch: ThemeColors.primary
);
