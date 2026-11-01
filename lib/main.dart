import 'dart:developer';

import 'package:aura_maison_e_commerce/core/theme/aura_theme.dart';
import 'package:aura_maison_e_commerce/core/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/home/presentation/screens/home_screen.dart';

void main() {
  runApp(const AuraMaisonApp());
}

class AuraMaisonApp extends StatelessWidget {
  const AuraMaisonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          log('Current theme: $themeMode');
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AuraTheme.lightTheme,
            darkTheme: AuraTheme.darkTheme,
            themeMode: themeMode,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}