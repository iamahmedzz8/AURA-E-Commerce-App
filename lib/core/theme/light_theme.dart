import 'package:flutter/material.dart';

class LightTheme {
  LightTheme._();

  static const Color backgroundColor = Color(0xFFF8F7F4);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color primaryColor = Color(0xFFC9A45C);
  static const Color textColor = Color(0xFF171717);
  static const Color secondaryTextColor = Color(0xFF777777);
  static const Color borderColor = Color(0xFFE5E1D8);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,
      fontFamily: 'Inter',
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: primaryColor,
        surface: surfaceColor,
        onSurface: textColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: 'EB Garamond',
          fontSize: 24,
          color: textColor,
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'EB Garamond',
          color: textColor,
        ),
        displayMedium: TextStyle(
          fontFamily: 'EB Garamond',
          color: textColor,
        ),
        headlineLarge: TextStyle(
          fontFamily: 'EB Garamond',
          color: textColor,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'EB Garamond',
          color: textColor,
        ),
        titleLarge: TextStyle(
          fontFamily: 'EB Garamond',
          color: textColor,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Inter',
          color: textColor,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Inter',
          color: textColor,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Inter',
          color: secondaryTextColor,
        ),
        labelLarge: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
      iconTheme: const IconThemeData(
        color: textColor,
        size: 20,
      ),
      dividerColor: borderColor,
      cardColor: surfaceColor,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        hintStyle: const TextStyle(
          fontFamily: 'Inter',
          color: secondaryTextColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryColor),
        ),
      ),
    );
  }
}