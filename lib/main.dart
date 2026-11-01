import 'package:aura_maison_e_commerce/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AuraMaisonApp());
}

class AuraMaisonApp extends StatelessWidget {
  const AuraMaisonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
