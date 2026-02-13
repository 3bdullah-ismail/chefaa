import 'package:flutter/material.dart';

import '../resources/color_manager.dart';

class CustomTextBtn extends StatelessWidget {
  const CustomTextBtn({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
  });

  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: color ?? ColorManager.primary,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          decoration: TextDecoration.underline,
          decorationColor: ColorManager.primary,
          decorationThickness: 1.5,
          height: 1.6,
        ),
      ),
    );
  }
}
