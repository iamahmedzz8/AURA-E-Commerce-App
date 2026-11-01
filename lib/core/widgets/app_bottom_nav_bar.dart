import 'package:flutter/material.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.isDark,
  });

  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final bool isDark;

  static const Color _gold = Color(0xFFC5A059);

  static const List<(IconData, String)> _items = [
    (Icons.home_outlined, 'HOME'),
    (Icons.diamond_outlined, 'COLLECTIONS'),
    (Icons.shopping_bag_outlined, 'BAG'),
    (Icons.favorite_border_rounded, 'FAVORITES'),
    (Icons.person_outline_rounded, 'PROFILE'),
  ];

  @override
  Widget build(BuildContext context) {
    final background =
    isDark ? const Color(0xFF080B10) : const Color(0xFF101216);

    return Container(
      decoration: BoxDecoration(
        color: background,
        border: Border(
          top: BorderSide(
            color: _gold.withValues(alpha: .12),
            width: .5,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: List.generate(_items.length, (index) {
            final selected = selectedIndex == index;
            final item = _items[index];

            return Expanded(
              child: InkWell(
                onTap: () => onItemSelected(index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item.$1,
                        color: selected ? _gold : Colors.white60,
                        size: 19,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.$2,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: selected ? _gold : Colors.white60,
                          fontSize: 7,
                          letterSpacing: .5,
                          fontWeight: selected
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}