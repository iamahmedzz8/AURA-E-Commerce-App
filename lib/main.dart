import 'package:flutter/material.dart';

import 'core/services/prefs_service.dart';
import 'core/widgets/auth_gate.dart';

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
      home: AuthGate(),
    );
  }
}
