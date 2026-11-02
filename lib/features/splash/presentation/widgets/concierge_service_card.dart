import 'package:aura_maison_e_commerce/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import '../../data/models/concierge_service_model.dart';

/// Reusable card component for displaying a Concierge Service item.
/// Driven by [ConciergeServiceModel].
class ConciergeServiceCard extends StatelessWidget {
  final ConciergeServiceModel service;
  final VoidCallback? onTap;

  const ConciergeServiceCard({super.key, required this.service, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.obsidianCard,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.obsidianBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          splashColor: AppColors.gold.withValues(alpha: 0.1),
          highlightColor: AppColors.gold.withValues(alpha: 0.05),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: Icon + Title + Tag Pill
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.obsidianDark,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: AppColors.gold.withValues(alpha: 0.25),
                          width: 0.8,
                        ),
                      ),
                      child: Icon(
                        service.icon,
                        size: 20,
                        color: AppColors.gold,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service.title,
                            style: const TextStyle(
                              color: AppColors.ivory,
                              fontSize: 14.5,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.2,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 11,
                                color: AppColors.luxuryMuted,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                service.location,
                                style: const TextStyle(
                                  color: AppColors.luxuryMuted,
                                  fontSize: 10,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.obsidianDark,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: AppColors.gold.withValues(alpha: 0.3),
                          width: 0.8,
                        ),
                      ),
                      child: Text(
                        service.tag,
                        style: const TextStyle(
                          color: AppColors.gold,
                          fontSize: 9.5,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Description copy
                Text(
                  service.description,
                  style: const TextStyle(
                    color: AppColors.luxuryMuted,
                    fontSize: 12,
                    height: 1.45,
                  ),
                ),
                if (service.badge != null) ...[
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.obsidianElevated,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          service.badge!,
                          style: TextStyle(
                            color: AppColors.goldLight.withValues(alpha: 0.9),
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
