import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';

class QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const QuantityButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        height: 32.h,
        width: 32.w,

        decoration: BoxDecoration(
          color: ColorManager.lightBlue,
          borderRadius: BorderRadius.circular(20.r),
        ),

        child: Icon(icon, size: 20.h, color: ColorManager.primary),
      ),
    );
  }
}
