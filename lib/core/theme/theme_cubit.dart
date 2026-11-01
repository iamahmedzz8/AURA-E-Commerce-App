import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.dark);

  void toggleTheme() {
    emit(
      state == ThemeMode.dark
          ? ThemeMode.light
          : ThemeMode.dark,
    );
  }

  void setDarkMode() {
    emit(ThemeMode.dark);
  }

  void setLightMode() {
    emit(ThemeMode.light);
  }
}