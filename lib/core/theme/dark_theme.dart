import 'package:flutter/material.dart';

class DarkTheme {
  DarkTheme._();

  static const Color backgroundColor = Color(0xFF101216);
  static const Color surfaceColor = Color(0xFF1B1E23);
  static const Color primaryColor = Color(0xFFC9A45C);
  static const Color textColor = Color(0xFFF5F1E8);
  static const Color secondaryTextColor = Color(0xFF9A9DA3);
  static const Color borderColor = Color(0xFF30343A);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,
      fontFamily: 'Inter',
      colorScheme: const ColorScheme.dark(
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