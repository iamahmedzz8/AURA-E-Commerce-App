import 'package:flutter/material.dart';
import '../../../../../core/theme/dark_theme.dart';

class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.image_outlined, color: DarkTheme.gold, size: 20),
            const SizedBox(width: 8),
            const Text('Gallery & Official Photos', style: TextStyle(color: DarkTheme.primaryText, fontSize: 20, fontFamily: 'EB Garamond', fontWeight: FontWeight.w600)),
            const Spacer(),
            Text('3 / 8 ACTIVE', style: TextStyle(color: DarkTheme.secondaryText.withOpacity(0.7), fontSize: 10, letterSpacing: 1, fontFamily: 'Inter')),
          ],
        ),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              Image.network(
                'https://picsum.photos/seed/watch_main/600/400',
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 12, left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)),
                  child: const Text('[PRIMARY] CALIBRE 8801', style: TextStyle(color: DarkTheme.gold, fontSize: 10, letterSpacing: 1, fontFamily: 'Inter', fontWeight: FontWeight.bold)),
                ),
              ),
              Positioned(
                top: 12, right: 12,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                  child: const Icon(Icons.grid_view, color: Colors.white, size: 14),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: DarkTheme.gold,
                  foregroundColor: DarkTheme.background,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                onPressed: () {},
                icon: const Icon(Icons.sync, size: 16),
                label: const Text('REPLACE PHOTO', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1, fontFamily: 'Inter')),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.redAccent.withOpacity(0.2), borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.redAccent)),
              child: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
            )
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildThumbnail('https://picsum.photos/seed/t1/200/200'),
            const SizedBox(width: 8),
            _buildThumbnail('https://picsum.photos/seed/t2/200/200'),
            const SizedBox(width: 8),
            _buildThumbnail('https://picsum.photos/seed/t3/200/200'),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 60,
                decoration: BoxDecoration(color: DarkTheme.surface, borderRadius: BorderRadius.circular(4), border: Border.all(color: DarkTheme.border)),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: DarkTheme.secondaryText, size: 16),
                    SizedBox(height: 2),
                    Text('ADD', style: TextStyle(color: DarkTheme.secondaryText, fontSize: 8, fontFamily: 'Inter')),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildThumbnail(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Image.network(url, width: 60, height: 60, fit: BoxFit.cover),
    );
  }
}