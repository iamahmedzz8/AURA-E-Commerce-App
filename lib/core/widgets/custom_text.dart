import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? size, space;
  final Color? color;
  final FontWeight? weight;
  final TextAlign? align;
  final String? family;
  final int? maxLines;

  const CustomText({
    super.key,
    required this.text,
    this.size,
    this.color,
    this.weight,
    this.align,
    this.family,
    this.maxLines,
    this.space,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,

      overflow: TextOverflow.ellipsis,
      textAlign: align,

      style: TextStyle(
        letterSpacing: space ?? 1,
        fontSize: size ?? 16,
        fontFamily: family ?? '',
        color: color,
        fontWeight: weight,
      ),
    );
  }
}
