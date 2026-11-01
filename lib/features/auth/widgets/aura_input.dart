
import 'package:aura_maison/core/constants/app_colors.dart';
import 'package:flutter/material.dart';


class AuraInput extends StatelessWidget {
  final String hint;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffix;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const AuraInput({
    super.key,
    required this.hint,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffix,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    obscureText: obscureText,
    keyboardType: keyboardType,
    validator: validator,
    style: const TextStyle(fontSize: 14, color: AppColors.ink),
    decoration: InputDecoration(
      filled: true,
      fillColor: AppColors.field,
      contentPadding: const EdgeInsets.symmetric(vertical: 17),
      prefixIcon: Icon(prefixIcon, color: AppColors.muted, size: 20),
      suffixIcon: suffix,
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF6F7580), fontSize: 13),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: AppColors.orange)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: AppColors.error)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: AppColors.error)),
    ),
  );
}
