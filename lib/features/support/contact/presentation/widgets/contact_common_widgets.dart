
import 'package:flutter/material.dart';
import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';

class ContactSectionLabel extends StatelessWidget {
  final String title;
  final String? trailing;

  const ContactSectionLabel({
    super.key,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 300;

        return Padding(
          padding: const EdgeInsets.only(bottom: 9),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 5,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isNarrow
                      ? constraints.maxWidth
                      : constraints.maxWidth * 0.7,
                ),
                child: Text(
                  title.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.goldAccent,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              if (trailing != null)
                Text(
                  trailing!,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class ContactMandateBadge extends StatelessWidget {
  const ContactMandateBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 440),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF25282D),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.shield_outlined,
            size: 13,
            color: AppColors.goldAccent,
          ),
          const SizedBox(width: 7),
          Flexible(
            child: Text(
              'PRIVATE REQUEST MANDATE • PLACE VENDÔME',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.goldAccent,
                fontSize: 10,
                letterSpacing: 0.7,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
