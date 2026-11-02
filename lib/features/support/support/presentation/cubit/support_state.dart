
import 'package:flutter/material.dart';
import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';

enum SupportRequestStatus {
  success,
  error,
}

class SupportRequestResult extends StatelessWidget {
  final SupportRequestStatus status;
  final VoidCallback onTryAgain;
  final VoidCallback onBackToSupport;

  const SupportRequestResult({
    super.key,
    required this.status,
    required this.onTryAgain,
    required this.onBackToSupport,
  });

  bool get isSuccess => status == SupportRequestStatus.success;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 28,
          vertical: 40,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Status Icon
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.obsidianCard,
                border: Border.all(
                  color: isSuccess
                      ? AppColors.goldAccent.withOpacity(0.35)
                      : Colors.redAccent.withOpacity(0.35),
                ),
              ),
              child: Icon(
                isSuccess
                    ? Icons.check_circle_outline_rounded
                    : Icons.error_outline_rounded,
                color: isSuccess
                    ? AppColors.goldAccent
                    : Colors.redAccent,
                size: 55,
              ),
            ),

            const SizedBox(height: 30),

            // Status Label
            Text(
              isSuccess ? 'REQUEST RECEIVED' : 'REQUEST FAILED',
              style: TextStyle(
                color: isSuccess
                    ? AppColors.goldAccent
                    : Colors.redAccent,
                fontSize: 10,
                letterSpacing: 2,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 14),

            // Title
            Text(
              isSuccess
                  ? 'Thank You for Reaching Out'
                  : 'Something Went Wrong',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.ivory,
                fontSize: 27,
                fontFamily: 'EB Garamond',
                height: 1.2,
              ),
            ),

            const SizedBox(height: 14),

            // Description
            Text(
              isSuccess
                  ? 'Your request has been successfully submitted. '
                    'Our concierge team will be in touch with you shortly.'
                  : 'We could not submit your request at this time. '
                    'Please check your connection and try again.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.luxuryMuted,
                fontSize: 12,
                height: 1.7,
              ),
            ),

            const SizedBox(height: 32),

            // Primary Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isSuccess
                    ? onBackToSupport
                    : onTryAgain,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.goldAccent,
                  foregroundColor: AppColors.iconDark,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: Text(
                  isSuccess
                      ? 'BACK TO SUPPORT'
                      : 'TRY AGAIN',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Secondary Button
            TextButton(
              onPressed: onBackToSupport,
              child: const Text(
                'BACK TO SUPPORT',
                style: TextStyle(
                  color: AppColors.luxuryMuted,
                  fontSize: 10,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
