import 'package:flutter/material.dart';

import 'dark_theme.dart';
import 'light_theme.dart';

class AuraTheme {
  AuraTheme._();

  static ThemeData get darkTheme => DarkTheme.theme;

  static ThemeData get lightTheme => LightTheme.theme;
}
