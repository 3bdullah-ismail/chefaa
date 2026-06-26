import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';

class HorizontalInfoBadge extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const HorizontalInfoBadge({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: ColorManager.lightBlue.withAlpha(50),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: ColorManager.primary),
      ),
      child: Row(
        children: [
          Container(
            width: 42.w,
            height: 42.h,
            decoration: BoxDecoration(
              color: color.withAlpha(50),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(icon, color: color, size: 20.sp),
          ),

          12.horizontalSpace,

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: getMediumStyle(
                  color: ColorManager.darkGray,
                  fontSize: 12.sp,
                ),
              ),

              4.verticalSpace,

              Text(
                value,
                style: getBoldStyle(color: ColorManager.black, fontSize: 14.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
