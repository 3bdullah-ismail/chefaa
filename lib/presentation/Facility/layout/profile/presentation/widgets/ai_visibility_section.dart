import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AiVisibilitySection extends StatelessWidget {
  const AiVisibilitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.p16.r),
      decoration: BoxDecoration(
        color: ColorManager.lightBlue.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(AppRadius.r20.r),
        border: Border.all(
          color: ColorManager.lightBlue.withValues(alpha: 0.55),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.auto_awesome_rounded,
                color: ColorManager.primary,
                size: 16.sp,
              ),
              SizedBox(width: AppSize.s8.w),
              Expanded(
                child: Text(
                  'AI Visibility — Active',
                  style: getBoldStyle(
                    color: const Color(0xFF0369A1),
                    fontSize: FontSize.s13.sp,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '+12%',
                    style: getBoldStyle(
                      color: ColorManager.lightGreen,
                      fontSize: FontSize.s14.sp,
                    ),
                  ),
                  Text(
                    'Discovery',
                    style: getRegularStyle(
                      color: ColorManager.gray,
                      fontSize: FontSize.s9.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: AppSize.s8.h),
          Text(
            'Your center is currently in the top 5% of regional AI ranking.',
            style: getRegularStyle(
              color: ColorManager.darkGray,
              fontSize: FontSize.s12.sp,
            ),
          ),
          SizedBox(height: AppSize.s12.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(AppRadius.r12.r),
              border: Border.all(
                color: ColorManager.lightBlue.withValues(alpha: 0.55),
                width: 1.w,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    'AI',
                    style: getBoldStyle(
                      color: ColorManager.primary,
                      fontSize: FontSize.s10.sp,
                    ),
                  ),
                ),
                SizedBox(width: AppSize.s8.w),
                Text(
                  'Ranking higher for "MRI Maadi"',
                  style: getMediumStyle(
                    color: ColorManager.darkGray,
                    fontSize: FontSize.s11.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
