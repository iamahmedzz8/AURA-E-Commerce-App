import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';

class IdentitySection extends StatelessWidget {
  const IdentitySection({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: DarkTheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: DarkTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.fingerprint, color: DarkTheme.gold, size: 18),
              SizedBox(width: 10),
              Text(
                'PIECE IDENTITY & ORIGIN',
                style: TextStyle(
                  color: DarkTheme.primaryText,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'PIECE NAME',
            style: TextStyle(
              color: DarkTheme.secondaryText,
              fontSize: 9,
              letterSpacing: 1,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            style: const TextStyle(
              color: DarkTheme.primaryText,
              fontSize: 18,
              fontFamily: 'EB Garamond',
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              hintText: 'Royal Tourbillon Mystérieux',
              hintStyle: TextStyle(
                color: DarkTheme.secondaryText.withOpacity(0.5),
                fontSize: 18,
                fontFamily: 'EB Garamond',
                fontWeight: FontWeight.w600,
              ),
              filled: true,
              fillColor: DarkTheme.background,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: DarkTheme.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: DarkTheme.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: DarkTheme.gold),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'WORKSHOP REFERENCE (SKU)',
                style: TextStyle(
                  color: DarkTheme.secondaryText,
                  fontSize: 9,
                  letterSpacing: 1,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.lock_outline, color: DarkTheme.gold, size: 12),
                  SizedBox(width: 4),
                  Text(
                    'Sealed',
                    style: TextStyle(
                      color: DarkTheme.gold,
                      fontSize: 10,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            style: const TextStyle(
              color: DarkTheme.gold,
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
            decoration: InputDecoration(
              hintText: '#TS-990-PT',
              hintStyle: TextStyle(
                color: DarkTheme.secondaryText.withOpacity(0.5),
                fontSize: 14,
                fontFamily: 'Inter',
              ),
              filled: true,
              fillColor: DarkTheme.background,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: DarkTheme.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: DarkTheme.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: DarkTheme.gold),
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.copy, color: DarkTheme.secondaryText, size: 18), // صغرناها
                onPressed: () {
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'WATCHMAKING CATEGORY',
            style: TextStyle(
              color: DarkTheme.secondaryText,
              fontSize: 9,
              letterSpacing: 1,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: DarkTheme.background,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: DarkTheme.border),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                dropdownColor: DarkTheme.surface,
                icon: const Icon(Icons.keyboard_arrow_down, color: DarkTheme.secondaryText, size: 18),
                hint: const Text(
                  'Fine Watchmaking',
                  style: TextStyle(
                    color: DarkTheme.primaryText,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
                items: const [],
                onChanged: (value) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}