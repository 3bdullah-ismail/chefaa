import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';

class MiniActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool filled;

  const MiniActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: filled ? ColorManager.primary : ColorManager.lightGray,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: filled ? ColorManager.white : ColorManager.primary,
            size: 20.r,
          ),
          4.verticalSpace,
          Text(
            label,
            style: getMediumStyle(
              color: filled ? ColorManager.white : ColorManager.black,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}
