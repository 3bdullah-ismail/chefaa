import 'package:chefaa/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

BoxDecoration confirmBookingCardDecoration({bool isSelected = false}) =>
    BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: isSelected ? ColorManager.primary : ColorManager.input,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
