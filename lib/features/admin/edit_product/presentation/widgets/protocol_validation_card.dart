import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';
import '../../../../../core/utils/app_strings.dart';

class ProtocolValidationCard extends StatelessWidget {
  const ProtocolValidationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2520), // Very dark green background
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.verified, color: Colors.greenAccent, size: 18),
              const SizedBox(width: 8),
              const Text(
                AppStrings.fineWatchmakingProtocol,
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 10,
                  letterSpacing: 1,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.close,
                color: DarkTheme.secondaryText.withValues(alpha: 0.5),
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            AppStrings.protocolChangesValidated,
            style: TextStyle(
              color: DarkTheme.primaryText,
              fontSize: 12,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.cryptographicTimestamp,
            style: TextStyle(
              color: DarkTheme.secondaryText.withValues(alpha: 0.7),
              fontSize: 10,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}
