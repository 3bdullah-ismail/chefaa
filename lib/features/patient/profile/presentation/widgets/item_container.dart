import 'package:flutter/material.dart';

import 'package:chefaa/core/extensions/build_ex.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';

class ItemContainer extends StatelessWidget {
  const ItemContainer({
    super.key,
    required this.child,
    this.isMedication = false,
  });

  final Widget child;
  final bool isMedication;

  @override
  Widget build(BuildContext context) {
    final widthFactor = isMedication ? 0.9 : 0.8;

    return Container(
      width: context.width * widthFactor,
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p14,
        vertical: AppPadding.p14,
      ),
      decoration: BoxDecoration(
        color: ColorManager.lightGray,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: ColorManager.input),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}
