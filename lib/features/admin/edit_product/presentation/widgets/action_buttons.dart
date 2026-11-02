import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';

class EditActionButtons extends StatelessWidget {
  const EditActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: DarkTheme.gold,
              foregroundColor: DarkTheme.background,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            ),
            onPressed: () {},
            icon: const Icon(Icons.save_outlined, size: 18),
            label: const Text('UPDATE SOVEREIGN RECORD', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1, fontSize: 12, fontFamily: 'Inter')),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: DarkTheme.primaryText,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () {},
            icon: const Icon(Icons.visibility_outlined, size: 18, color: DarkTheme.gold),
            label: const Text('VIEW CLIENT RECORD (SALON VIEW)', style: TextStyle(fontSize: 11, letterSpacing: 0.5, fontFamily: 'Inter')),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent.withOpacity(0.1),
              foregroundColor: Colors.redAccent,
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4), side: BorderSide(color: Colors.redAccent.withOpacity(0.3))),
            ),
            onPressed: () {},
            icon: const Icon(Icons.delete_forever_outlined, size: 18),
            label: const Text('REMOVE / DECLASSIFY PIECE FROM REGISTER', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5, fontSize: 10, fontFamily: 'Inter')),
          ),
        ),
      ],
    );
  }
}