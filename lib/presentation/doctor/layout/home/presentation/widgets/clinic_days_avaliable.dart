import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/resources/color_manager.dart';

class ClinicDaysAvailable extends StatelessWidget {
  final String day;

  const ClinicDaysAvailable({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: ColorManager.input,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        day.substring(0, 3),
        style: getBoldStyle(color: ColorManager.gray, fontSize: 12),
      ),
    );
  }
}
