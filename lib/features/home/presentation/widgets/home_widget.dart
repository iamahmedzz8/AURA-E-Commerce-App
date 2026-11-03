import 'package:flutter/material.dart';

class HomeProductCard extends StatelessWidget {
  final Map<String, String> product;
  final bool isDark;
  final bool isFavorite;
  final VoidCallback onFavorite;
  final VoidCallback onReserve;

  const HomeProductCard({
    super.key,
    required this.product,
    required this.isDark,
    required this.isFavorite,
    required this.onFavorite,
    required this.onReserve,
  });

  static const gold = Color(0xFFC5A059);

  @override
  Widget build(BuildContext context) {
    final foreground =
    isDark ? Colors.white : const Color(0xFF171717);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF191C21) : Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  product['image']!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                  const ColoredBox(color: Color(0xFF191C21)),
                ),
                Positioned(
                  top: 7,
                  right: 7,
                  child: IconButton(
                    onPressed: onFavorite,
                    icon: Icon(
                      isFavorite
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: isFavorite ? gold : foreground,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['category']!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: gold,
                    fontSize: 8,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  product['name']!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: foreground,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  product['price']!,
                  style: TextStyle(
                    color: foreground,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: OutlinedButton(
                    onPressed: onReserve,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: foreground,
                      side: const BorderSide(color: gold),
                    ),
                    child: const Text(
                      'RESERVE',
                      style: TextStyle(fontSize: 9),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
