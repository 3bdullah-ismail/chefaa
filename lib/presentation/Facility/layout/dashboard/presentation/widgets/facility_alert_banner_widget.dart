import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FacilityAlertBannerWidget extends StatelessWidget {
  const FacilityAlertBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF3C7), // Amber 100
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFFDE68A), // Amber 200
          width: 1.w,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: const Color(0xFFD97706), // Amber 600
            size: 24.sp,
          ),
          SizedBox(width: AppSize.s12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "2 results ready to upload",
                  style: getBoldStyle(
                    color: const Color(0xFF92400E), // Amber 800
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: AppSize.s2.h),
                Text(
                  "These require urgent attention for patient Sara Rashed.",
                  style: getRegularStyle(
                    color: const Color(0xFFB45309), // Amber 700
                    fontSize: FontSize.s10.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: AppSize.s8.w),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF59E0B),
              // Amber 500
              foregroundColor: ColorManager.white,
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              elevation: 0,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              "Review",
              style: getBoldStyle(color: ColorManager.white, fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }
}
