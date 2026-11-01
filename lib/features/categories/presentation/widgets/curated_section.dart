import 'package:aura_maison/core/utils/app_colors.dart';
import 'package:aura_maison/core/utils/app_strings.dart';
import 'package:aura_maison/core/utils/app_styles.dart';
import 'package:aura_maison/features/categories/data/models/workshop_item.dart';
import 'package:flutter/material.dart';

class CuratedSection extends StatefulWidget {
  const CuratedSection({super.key});

  @override
  State<CuratedSection> createState() => _CuratedSectionState();
}

class _CuratedSectionState extends State<CuratedSection> {
  int selectedIndex = 0;

  final List<WorkshopItem> workshops = const [
    WorkshopItem(
      tag: AppStrings.watchmakingTag,
      title: AppStrings.watchmakingTitle,
      subtitle: AppStrings.watchmakingSubtitle,
      pieceCount: AppStrings.watchmakingPieces,
      imageUrl:
          'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?q=80&w=600',
    ),
    WorkshopItem(
      tag: AppStrings.jewelryTag,
      title: AppStrings.jewelryTitle,
      subtitle: AppStrings.jewelrySubtitle,
      pieceCount: AppStrings.jewelryPieces,
      imageUrl:
          'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?q=80&w=600',
    ),
    WorkshopItem(
      tag: AppStrings.leatherTag,
      title: AppStrings.leatherTitle,
      subtitle: AppStrings.leatherSubtitle,
      pieceCount: AppStrings.leatherPieces,
      imageUrl:
          'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?q=80&w=600',
    ),
    WorkshopItem(
      tag: AppStrings.accessoriesTag,
      title: AppStrings.accessoriesTitle,
      subtitle: AppStrings.accessoriesSubtitle,
      pieceCount: AppStrings.accessoriesPieces,
      imageUrl:
          'https://images.unsplash.com/photo-1511499767150-a48a237f0083?q=80&w=600',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header Row
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.curatedDepartments,
                    style: AppStyles.sectionEyebrow.copyWith(
                      color: AppColors.goldAccent,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    AppStrings.privateWorkshops,
                    style: AppStyles.sectionHeading.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  AppStrings.rarePiecesCount,
                  style: AppStyles.sectionCount.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Horizontal Carousel
        SizedBox(
          height: 265,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: workshops.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final item = workshops[index];
              final isSelected = index == selectedIndex;
              return GestureDetector(
                onTap: () => setState(() => selectedIndex = index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 256,
                  height: 265,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.cardActive
                        : AppColors.cardInactive,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Image Area with Badge & Gradient
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(8)),
                        child: SizedBox(
                          height: 176,
                          width: double.infinity,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                item.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  color: AppColors.cardInactive,
                                  child: const Icon(
                                    Icons.image_outlined,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                              // Subtle bottom vignette gradient
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      (isSelected
                                              ? AppColors.cardActive
                                              : AppColors.cardInactive)
                                          .withValues(alpha: 0.6),
                                    ],
                                  ),
                                ),
                              ),
                              // Piece Count Badge
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.badgeBackground,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    item.pieceCount,
                                    style: AppStyles.badgeText.copyWith(
                                      color: isSelected
                                          ? AppColors.goldAccent
                                          : AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Bottom Metadata Area
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Category Tag + Active Indicator Dot
                            Row(
                              children: [
                                if (isSelected) ...[
                                  Container(
                                    width: 6,
                                    height: 6,
                                    margin: const EdgeInsets.only(right: 6),
                                    decoration: const BoxDecoration(
                                      color: AppColors.goldBright,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                                Text(
                                  item.tag,
                                  style: AppStyles.cardTag.copyWith(
                                    color: isSelected
                                        ? AppColors.goldAccent
                                        : AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            // Workshop Title
                            Text(
                              item.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.cardHeading.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            // Subtitle
                            Text(
                              item.subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.cardSubtitle.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
