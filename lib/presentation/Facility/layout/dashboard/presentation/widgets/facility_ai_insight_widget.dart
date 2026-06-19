import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FacilityAiInsightWidget extends StatelessWidget {
  const FacilityAiInsightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1B2536),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.auto_awesome_rounded,
                color: ColorManager.white,
                size: 16.sp,
              ),
              SizedBox(width: AppSize.s8.w),
              Text(
                "AI SMART INSIGHTS",
                style: getBoldStyle(color: ColorManager.white, fontSize: 12.sp),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            "AI referred 18 patients today",
            style: getBoldStyle(color: ColorManager.white, fontSize: 16.sp),
          ),
          SizedBox(height: 6.h),
          Text(
            "Your facility is currently ranked #1 for MRI precision in Cairo East.",
            style: getRegularStyle(
              color: const Color(0xFF94A3B8),
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0284C7),
              foregroundColor: ColorManager.white,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "View Ranking Details",
                  style: getBoldStyle(
                    color: ColorManager.white,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(width: 6.w),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: ColorManager.white,
                  size: 14.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
