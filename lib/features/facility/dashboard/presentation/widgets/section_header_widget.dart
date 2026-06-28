import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';

class SectionHeaderWidget extends StatelessWidget {
  final String title;
  final String? badgeText;
  final Color? badgeColor;
  final Color? badgeTextColor;

  const SectionHeaderWidget({
    super.key,
    required this.title,
    this.badgeText,
    this.badgeColor,
    this.badgeTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: getBoldStyle(
            color: ColorManager.slate900,
            fontSize: FontSize.s14.sp,
          ),
        ),
        if (badgeText != null) ...[
          SizedBox(width: AppSize.s8.w),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.p8.w,
              vertical: AppPadding.p3.h,
            ),
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(AppRadius.r8.r),
            ),
            child: Text(
              badgeText!,
              style: getBoldStyle(
                color: badgeTextColor ?? ColorManager.error,
                fontSize: FontSize.s10.sp,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
