import 'package:flutter/material.dart';
import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';

class FavoritesHeaderSection extends StatelessWidget {
  final int itemCount;

  const FavoritesHeaderSection({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PRIVATE VAULT · CURATION №',
            style: TextStyle(
              color: AppColors.goldAccent,
              fontSize: 10,
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              const Expanded(
                child: Text(
                  'Private Vault Favorites',
                  style: TextStyle(
                    color: Color(0xFFFBF9F5),
                    fontSize: 28,
                    fontFamily: 'EB Garamond',
                  ),
                ),
              ),

              Text(
                '$itemCount ITEMS',
                style: const TextStyle(
                  color: Color(0xFF8A8F98),
                  fontSize: 10,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          const Text(
            'A private collection of pieces selected for you.',
            style: TextStyle(color: Color(0xFF8A8F98), fontSize: 12),
          ),
        ],
      ),
    );
  }
}
