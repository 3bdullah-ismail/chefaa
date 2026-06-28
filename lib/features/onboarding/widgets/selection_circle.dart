import 'package:flutter/material.dart';

import 'package:chefaa/core/resources/color_manager.dart';

class SelectionCircle extends StatelessWidget {
  final bool isSelected;

  const SelectionCircle({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? ColorManager.primary : Colors.transparent,
        border: Border.all(
          color: isSelected ? ColorManager.primary : ColorManager.gray,
          width: 2,
        ),
      ),
    );
  }
}
