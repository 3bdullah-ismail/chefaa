import 'package:flutter/material.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/resources/assets_manager.dart';

class HealthIndicator extends StatelessWidget {
  const HealthIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppPadding.p20),
      decoration: BoxDecoration(
        color: ColorManager.lightGray,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: ColorManager.input, width: 1),
        boxShadow: [
          BoxShadow(color: ColorManager.black.withAlpha(80), blurRadius: 10),
        ],
      ),
      child: Image.asset(ImageAssets.healthIndicator, fit: BoxFit.contain),
    );
  }
}
