import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:aura_maison_e_commerce/core/widgets/aura_text.dart';
import 'package:flutter/material.dart';

import '../../data/models/bag_item_model.dart';

class BagPreviewCard extends StatelessWidget {
  final BagItemModel item;
  const BagPreviewCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFF9BC9DE), width: 1.2),
    ),
    child: Row(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: const Color(0xFFE8E3DB),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.shopping_bag_outlined,
            size: 34,
            color: Color(0xFF8A7662),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.circle, size: 7, color: AppColors.orange),
                  const SizedBox(width: 5),
                  Expanded(
                    child: AuraText(
                      item.status,
                      size: 9,
                      weight: FontWeight.w700,
                      color: AppColors.muted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              AuraText(
                item.title,
                size: 15,
                weight: FontWeight.w700,
                maxLines: 2,
              ),
              const SizedBox(height: 3),
              AuraText(item.subtitle, size: 11, color: AppColors.muted),
            ],
          ),
        ),
      ],
    ),
  );
}
