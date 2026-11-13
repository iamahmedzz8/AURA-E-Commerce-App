import 'package:flutter/material.dart';

class ProductDetailsInfoRow extends StatelessWidget {
  final String title;
  final String value;
  final Color textColor;
  final Color mutedColor;
  final Color dividerColor;

  const ProductDetailsInfoRow({
    super.key,
    required this.title,
    required this.value,
    required this.textColor,
    required this.mutedColor,
    required this.dividerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: dividerColor)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: mutedColor,
                fontSize: 12,
                fontFamily: 'Inter',
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: textColor,
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
