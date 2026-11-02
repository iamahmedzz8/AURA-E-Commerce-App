import 'package:flutter/material.dart';
import 'package:aura_maison_e_commerce/core/utils/app_colors.dart';

class CuratorCard extends StatelessWidget {
  final String? imageUrl;

  const CuratorCard({super.key, this.imageUrl});

  Widget _buildAvatar() {
    final hasImage = imageUrl != null && imageUrl!.trim().isNotEmpty;

    return CircleAvatar(
      radius: 25,
      backgroundColor: const Color(0xFF30343A),
      child: ClipOval(
        child: SizedBox(
          width: 50,
          height: 50,
          child: hasImage
              ? Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const Icon(
                    Icons.person,
                    color: AppColors.textSecondary,
                    size: 30,
                  ),
                )
              : const Icon(
                  Icons.person,
                  color: AppColors.textSecondary,
                  size: 30,
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 330;

        return Container(
          padding: EdgeInsets.all(isNarrow ? 12 : 16),
          decoration: BoxDecoration(
            color: const Color(0xFF1D2025),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  _buildAvatar(),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 13,
                      height: 13,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00B887),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF1D2025),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'DEDICATED CURATOR',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.goldAccent,
                        fontSize: 10,
                        letterSpacing: 0.7,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Jean-Baptiste Laurent',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: isNarrow ? 15 : 17,
                        fontFamily: 'EB Garamond',
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'Vendôme Office • Private Line active',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF30343A),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: const Icon(
                  Icons.verified_user_outlined,
                  color: AppColors.goldAccent,
                  size: 19,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CuratorAvailabilityCard extends StatelessWidget {
  const CuratorAvailabilityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF303238),
        borderRadius: BorderRadius.circular(9),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.access_time, color: AppColors.goldAccent, size: 17),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'CURATOR AVAILABILITY',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.goldAccent,
                    fontSize: 10,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 7),
          Text(
            'Our curators handle requests Monday to Saturday, '
            '9h to 20h CET (on-call arrangements by agreement).',
            style: TextStyle(
              color: Color(0xFFC4BBAF),
              fontSize: 11,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
