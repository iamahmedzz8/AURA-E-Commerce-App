import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';

class ImagerySection extends StatelessWidget {
  const ImagerySection({super.key});

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.camera_alt_outlined,
                    color: DarkTheme.gold,
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'WORKSHOP IMAGERY',
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
              const Text(
                'Photos 1 / 8',
                style: TextStyle(
                  color: DarkTheme.gold,
                  fontSize: 10,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 32),
            decoration: BoxDecoration(
              color: DarkTheme.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: DarkTheme.border),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: DarkTheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: DarkTheme.border),
                  ),
                  child: const Icon(
                    Icons.add_photo_alternate_outlined,
                    color: DarkTheme.gold,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Drop 360° studio\nphotographs',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: DarkTheme.primaryText,
                    fontSize: 20,
                    fontFamily: 'EB Garamond',
                    height: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Lossless RAW / PNG • Angle certificate\nrequired (Max 8 photos)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: DarkTheme.secondaryText,
                    fontSize: 10,
                    fontFamily: 'Inter',
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 65,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: DarkTheme.background,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: DarkTheme.border),
                            image: const DecorationImage(
                              image: NetworkImage(
                                'https://picsum.photos/seed/mvt/200/200',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: CircleAvatar(
                            backgroundColor: Colors.black.withValues(
                              alpha: 0.6,
                            ),
                            radius: 9,
                            child: const Icon(
                              Icons.close,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 4,
                          left: 4,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.6),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: const Text(
                              'MVT 01',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _buildAddButton('Dial'),
              const SizedBox(width: 8),
              _buildAddButton('Case'),
              const SizedBox(width: 8),
              _buildAddButton('On Wrist'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton(String label) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 65,
            width: double.infinity,
            decoration: BoxDecoration(
              color: DarkTheme.background,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: DarkTheme.border),
            ),
            child: const Center(
              child: Icon(Icons.add, color: DarkTheme.secondaryText, size: 22),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: DarkTheme.secondaryText,
              fontSize: 9,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}
