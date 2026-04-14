import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/resources/values_manager.dart';

class OverViewCard extends StatelessWidget {
  final String label;
  final String title;
  final bool isActive;

  const OverViewCard({
    super.key,
    this.isActive = false,
    required this.label,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: ColorManager.lightGray,
        border: Border.all(
          color:  ColorManager.input
        ),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(60),
            blurRadius: 7,
            offset: const Offset(1, 5),
          ),
        ],
      ),
      height: 90,
      width: 180,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p12,
          vertical: AppPadding.p12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              label,
              style: getRegularStyle(
                color: ColorManager.black,
              ).copyWith(fontSize: 17),
            ),
            Text(
              title,
              style: getBoldStyle(
                color: isActive ? ColorManager.black : ColorManager.lightGreen,
              ).copyWith(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
