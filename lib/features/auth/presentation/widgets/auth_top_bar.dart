import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

/// Reusable Top Bar for Auth screens (Login, Signup, OTP, Forgot, Reset)
class AuthTopBar extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final VoidCallback? onBack;
  final bool showAvatar;
  final IconData backIcon;

  const AuthTopBar({
    super.key,
    this.title,
    this.titleWidget,
    this.onBack,
    this.showAvatar = true,
    this.backIcon = Icons.arrow_back_ios_new,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: onBack ?? () => Navigator.maybePop(context),
                icon: Icon(backIcon, size: 18, color: AppColors.ivory),
                splashRadius: 20,
              ),
              if (titleWidget != null) ...[
                const SizedBox(width: 4),
                titleWidget!,
              ] else if (title != null) ...[
                const SizedBox(width: 4),
                Text(
                  title!,
                  style: const TextStyle(
                    fontFamily: 'serif',
                    color: AppColors.ivory,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ],
          ),
          if (showAvatar)
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: AppColors.gold,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Icon(
                  Icons.person_outline,
                  size: 18,
                  color: AppColors.obsidianDark,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
