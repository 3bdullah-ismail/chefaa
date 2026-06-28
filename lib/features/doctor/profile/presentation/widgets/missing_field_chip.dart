import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';

class MissingFieldChip extends StatelessWidget {
  final String label;

  const MissingFieldChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.p12.w,
        vertical: AppPadding.p8.h,
      ),
      decoration: BoxDecoration(
        color: ColorManager.error.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadius.r9999.r),
        border: Border.all(color: ColorManager.error.withValues(alpha: 0.15)),
      ),
      child: Text(
        label,
        style: getMediumStyle(
          color: ColorManager.error,
          fontSize: FontSize.s12.sp,
        ),
      ),
    );
  }
}
