import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';

class SpecificationsSection extends StatelessWidget {
  const SpecificationsSection({super.key});

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
                  Icon(
                    Icons.workspace_premium_outlined,
                    color: DarkTheme.gold,
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'WATCHMAKING SPECIFICATIONS',
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
                'GENEVE CERT.',
                style: TextStyle(
                  color: DarkTheme.gold,
                  fontSize: 9,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _buildTextField(
            'CALIBRE & MOVEMENT',
            'AURA Cal. 8920 Manual • 21600 vph',
          ),
          const SizedBox(height: 12),
          _buildTextField(
            'CASE & PRECIOUS METAL',
            '950 Platinum (Hand-Brushed Finish)',
            isDropdown: true,
          ),
          const SizedBox(height: 12),
          _buildTextField(
            'PRECIOUS STONES / GEMS',
            'Royal Cabochon Sapphire 0.8ct',
          ),
          const SizedBox(height: 12),
          _buildTextField(
            'DIMENSIONS & WATER RESISTANCE',
            '41mm • Thickness 9.8mm • 50m',
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hint, {bool isDropdown = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: DarkTheme.secondaryText,
            fontSize: 10,
            letterSpacing: 1,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: isDropdown ? 0 : 14,
          ),
          decoration: BoxDecoration(
            color: DarkTheme.background,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: DarkTheme.border),
          ),
          child: isDropdown
              ? DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    dropdownColor: DarkTheme.surface,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: DarkTheme.secondaryText,
                      size: 18,
                    ),
                    hint: Text(
                      hint,
                      style: const TextStyle(
                        color: DarkTheme.primaryText,
                        fontSize: 14,
                        fontFamily: 'Inter',
                      ),
                    ),
                    items: const [],
                    onChanged: (value) {},
                  ),
                )
              : Text(
                  hint,
                  style: const TextStyle(
                    color: DarkTheme.primaryText,
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
        ),
      ],
    );
  }
}
