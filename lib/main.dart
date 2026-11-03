import 'package:aura_maison_e_commerce/core/di/injection_container.dart';
import 'package:aura_maison_e_commerce/core/services/prefs_service.dart';
import 'package:aura_maison_e_commerce/core/theme/theme_cubit.dart';
import 'package:aura_maison_e_commerce/core/theme/aura_theme.dart';
import 'package:aura_maison_e_commerce/features/splash/presentation/screens/splash_salon_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PrefsService.init();
  await initServiceLocator();

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
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AuraTheme.lightTheme,
            darkTheme: AuraTheme.darkTheme,
            themeMode: themeMode,
            home: const SplashSalonScreen(),
          );
        },
      ),
    );
  }
}