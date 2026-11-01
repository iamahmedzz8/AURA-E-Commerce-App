import 'package:aura_maison_e_commerce/core/services/prefs_service.dart';
import 'package:flutter/material.dart';
import 'features/splash/screens/splash_salon_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsService.init();
  runApp(const AuraMaisonApp());
}

class AuraMaisonApp extends StatelessWidget {
  const AuraMaisonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashSalonScreen(),
    );
  }
}
