import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';

class MissingFieldChip extends StatelessWidget {
  final String label;

  const MissingFieldChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: ColorManager.error.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(9999.r),
        border: Border.all(color: ColorManager.error.withValues(alpha: 0.15)),
      ),
      child: Text(
        label,
        style: getMediumStyle(color: ColorManager.error, fontSize: 12.sp),
      ),
    );
  }
}
