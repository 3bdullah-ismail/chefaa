import 'package:flutter/material.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';

class ClinicDaysAvailable extends StatelessWidget {
  final String day;
  final bool isAvailable; // ← تأكد إنها بتتستخدم

  const ClinicDaysAvailable({
    super.key,
    required this.day,
    required this.isAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        // ← لون مختلف لو اليوم متاح
        color: isAvailable ? ColorManager.primary.withAlpha(30) : ColorManager.input,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        day,
        style: getBoldStyle(
          // ← لون النص مختلف كمان
          color: isAvailable ? ColorManager.primary : ColorManager.gray,
          fontSize: 12,
        ),
      ),
    );
  }
}