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

  static final MaterialColor primaryLight = MaterialColor(
    0xFF4e97c7,
    const <int, Color> {
      50:  const Color(0xFF4e97c7),
      100: const Color(0xFF4e97c7),
      200: const Color(0xFF4e97c7),
      300: const Color(0xFF4e97c7),
      400: const Color(0xFF4e97c7),
      500: const Color(0xFF4e97c7),
      600: const Color(0xFF4e97c7),
      700: const Color(0xFF4e97c7),
      800: const Color(0xFF4e97c7),
      900: const Color(0xFF4e97c7),
    },
  );

  static final MaterialColor primaryDark = MaterialColor(
    0xFF003f68,
    const <int, Color> {
      50:  const Color(0xFF003f68),
      100: const Color(0xFF003f68),
      200: const Color(0xFF003f68),
      300: const Color(0xFF003f68),
      400: const Color(0xFF003f68),
      500: const Color(0xFF003f68),
      600: const Color(0xFF003f68),
      700: const Color(0xFF003f68),
      800: const Color(0xFF003f68),
      900: const Color(0xFF003f68),
    },
  );
}

final themeData = ThemeData(
  // This is the theme of your application.
  primaryColor: ThemeColors.primary,
  primarySwatch: ThemeColors.primary,
  primaryColorLight: ThemeColors.primaryLight,
  primaryColorDark: ThemeColors.primaryDark,
  buttonColor: ThemeColors.primaryDark,
);
