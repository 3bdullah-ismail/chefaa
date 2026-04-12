import 'package:flutter/material.dart';

import '../../../../../core/extensions/build_ex.dart';
import '../../../../../core/resources/color_manager.dart';

class ItemContainer extends StatelessWidget {
  const ItemContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.8,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: ColorManager.lightGray,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: ColorManager.input),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.25),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}
