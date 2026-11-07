import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';
import '../../../../../core/utils/app_strings.dart';

class IdentitySection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController nameArabicController;
  final TextEditingController descriptionController;

  const IdentitySection({
    super.key,
    required this.nameController,
    required this.nameArabicController,
    required this.descriptionController,
  });

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
                AppStrings.pieceIdentityOrigin,
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
            AppStrings.pieceName,
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
            controller: nameController,
            style: const TextStyle(
              color: DarkTheme.primaryText,
              fontSize: 18,
              fontFamily: 'EB Garamond',
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              hintText: AppStrings.pieceNamePlaceholder,
              hintStyle: TextStyle(
                color: DarkTheme.secondaryText.withValues(alpha: 0.5),
                fontSize: 18,
                fontFamily: 'EB Garamond',
                fontWeight: FontWeight.w600,
              ),
              filled: true,
              fillColor: DarkTheme.background,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
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
          const Text(
            AppStrings.description,
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
            controller: descriptionController,
            maxLines: 3,
            style: const TextStyle(
              color: DarkTheme.primaryText,
              fontSize: 14,
              fontFamily: 'Inter',
            ),
            decoration: InputDecoration(
              hintText: AppStrings.descriptionPlaceholder,
              hintStyle: TextStyle(
                color: DarkTheme.secondaryText.withValues(alpha: 0.5),
                fontSize: 14,
                fontFamily: 'Inter',
              ),
              filled: true,
              fillColor: DarkTheme.background,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
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
                AppStrings.workshopReferenceSku,
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
                    AppStrings.sealed,
                    style: TextStyle(
                      color: DarkTheme.gold,
                      fontSize: 10,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: nameArabicController,
            style: const TextStyle(
              color: DarkTheme.gold,
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
            decoration: InputDecoration(
              hintText: AppStrings.skuPlaceholder,
              hintStyle: TextStyle(
                color: DarkTheme.secondaryText.withValues(alpha: 0.5),
                fontSize: 14,
                fontFamily: 'Inter',
              ),
              filled: true,
              fillColor: DarkTheme.background,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
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
                icon: const Icon(
                  Icons.copy,
                  color: DarkTheme.secondaryText,
                  size: 18,
                ),
                onPressed: () {},
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            AppStrings.watchmakingCategory,
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
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: DarkTheme.secondaryText,
                  size: 18,
                ),
                hint: const Text(
                  AppStrings.fineWatchmaking,
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
