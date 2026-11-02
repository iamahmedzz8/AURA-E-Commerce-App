import 'package:aura_maison_e_commerce/core/services/prefs_service.dart';
import 'package:aura_maison_e_commerce/features/address/presntation/screens/my_address_screen.dart';
import 'package:aura_maison_e_commerce/features/cart/presentaion/screens/cart_screen.dart';
import 'package:aura_maison_e_commerce/features/profile/presentation/screens/edit_profile.dart';
import 'package:aura_maison_e_commerce/features/profile/presentation/screens/profile_screen.dart';
import 'package:aura_maison_e_commerce/features/splash/splash.dart';
import 'package:aura_maison_e_commerce/features/support/contact/presentation/screens/about_as.dart';
import 'package:aura_maison_e_commerce/features/support/contact/presentation/screens/contact_screen.dart';
import 'package:aura_maison_e_commerce/features/support/support/presentation/screens/police_privacy.dart';
import 'package:aura_maison_e_commerce/main_screen.dart';

import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsService.init();
  runApp(const AuraMaisonApp());
}

class AuraMaisonApp extends StatelessWidget {
  const AuraMaisonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
