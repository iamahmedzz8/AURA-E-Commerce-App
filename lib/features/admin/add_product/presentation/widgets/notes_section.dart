import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';

class NotesSection extends StatelessWidget {
  const NotesSection({super.key});

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Row(
                children: [
                  Icon(Icons.edit_note, color: DarkTheme.gold, size: 16),
                  SizedBox(width: 8),
                  Text(
                    'WORKSHOP NOTES & STORY',
                    style: TextStyle(
                      color: DarkTheme.primaryText,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
              Text(
                '184 / 600',
                style: TextStyle(
                  color: DarkTheme.secondaryText,
                  fontSize: 10,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            maxLines: 4,
            style: const TextStyle(
              color: DarkTheme.primaryText,
              fontSize: 14,
              fontFamily: 'Inter',
              height: 1.5,
            ),
            decoration: InputDecoration(
              hintText:
                  'Made in our quiet Vendôme workshop, this model suspends time via a flying tourbillon escapement. Its bridges are beveled and polished with elder pith.',
              hintStyle: TextStyle(
                color: DarkTheme.secondaryText.withValues(alpha: 0.5),
                fontSize: 14,
                height: 1.5,
                fontFamily: 'Inter',
              ),
              filled: true,
              fillColor: DarkTheme.background,
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: DarkTheme.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: DarkTheme.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: DarkTheme.gold),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.verified, size: 14, color: DarkTheme.gold),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Fields certified by the Master Curator before final publication in the international register.',
                  style: TextStyle(
                    color: DarkTheme.secondaryText.withValues(alpha: 0.8),
                    fontSize: 10,
                    height: 1.4,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
