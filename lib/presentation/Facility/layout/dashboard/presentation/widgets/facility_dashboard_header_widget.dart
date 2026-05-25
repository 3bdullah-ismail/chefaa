import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/core/widget/custom_circle_avatar.dart';

class FacilityDashboardHeaderWidget extends StatelessWidget {
  const FacilityDashboardHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomCircleAvatar(
            imagePath: ImageAssets.doctor,
            radius: AppSize.s35.r,
          ),
          SizedBox(width: AppSize.s12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Good morning",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getRegularStyle(
                    color: ColorManager.white,
                    fontSize: FontSize.s14.sp,
                  ),
                ),
                SizedBox(height: AppSize.s2.h),
                Text(
                  "Cairo MRI Center",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: getBoldStyle(
                    color: ColorManager.white,
                    fontSize: FontSize.s22.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: AppSize.s8.w),
          SizedBox(
            width: 40.w,
            height: 40.w,
            child: IconButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints.tightFor(width: 40, height: 40),
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    Icons.notifications_none_rounded,
                    color: ColorManager.white,
                    size: 32.sp,
                  ),
                  Positioned(
                    right: AppSize.s2.w,
                    top: AppSize.s2.h,
                    child: Container(
                      width: 6.r,
                      height: 6.r,
                      decoration: const BoxDecoration(
                        color: ColorManager.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
