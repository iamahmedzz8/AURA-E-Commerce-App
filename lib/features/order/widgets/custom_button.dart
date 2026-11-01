
import 'package:aura_maison_e_commerce/core/widgets/custom_text.dart';
import 'package:aura_maison_e_commerce/core/widgets/navigation.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget widget;
  final String buttonText;
  final Color buttonColor;
  final Color ?textColor;
  
  
  const CustomButton({super.key, required this.widget, required this.buttonText, required this.buttonColor,  this.textColor});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
          onTap: () => NavigateTo(context: context, screen: widget),
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: buttonColor,
            ),
            child: Center(
              child: CustomText(
                text: buttonText,
                color: textColor ?? Colors.black,
                weight: FontWeight.bold,
                size: 20,
              ),
            ),
          ),
        );
  }
}