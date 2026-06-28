import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';

class SmartScanBanner extends StatelessWidget {
  const SmartScanBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [ColorManager.violet600, ColorManager.purple700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Smart Scan",
                  style: getBoldStyle(
                    color: ColorManager.white,
                    fontSize: 18.sp,
                  ),
                ),
                6.verticalSpace,
                Text(
                  "Scan your doctor's request for instant AI-powered center matching and best prices.",
                  style: getRegularStyle(
                    color: ColorManager.white.withValues(alpha: 0.9),
                    fontSize: 13.sp,
                  ),
                ),
                12.verticalSpace,
                InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Get Started",
                        style: getBoldStyle(
                          color: ColorManager.white,
                          fontSize: 14.sp,
                        ),
                      ),
                      6.horizontalSpace,
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: ColorManager.white,
                        size: 16.sp,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          12.horizontalSpace,
          Container(
            width: 56.w,
            height: 56.h,
            decoration: BoxDecoration(
              color: ColorManager.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(12.r),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.qr_code_scanner_rounded,
              color: ColorManager.white,
              size: 28.sp,
            ),
          ),
        ],
      ),
    );
  }
}
