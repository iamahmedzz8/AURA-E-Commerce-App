import 'package:aura_maison/main_screen.dart';
import 'package:aura_maison/features/splash/screens/splash_salon_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const AuraApp());

class AuraApp extends StatelessWidget {
  const AuraApp({super.key});

  @override
  Widget build(BuildContext context) {
  return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AURA MAISON',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF101319),
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFC5A059),
          brightness: Brightness.dark,
        ),
      ),
      home: const SplashSalonScreen(),
    );
  }
}
