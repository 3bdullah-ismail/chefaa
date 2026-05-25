import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: getBoldStyle(
            color: ColorManager.black,
            fontSize: FontSize.s14.sp,
          ),
        ),
        SizedBox(height: AppSize.s8.h),
        Container(
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(AppRadius.r16.r),
            border: Border.all(
              color: ColorManager.input.withValues(alpha: 0.8),
              width: 1.w,
            ),
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.r),
                    ),
                    child: Image.asset(
                      ImageAssets.map,
                      height: 120.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: 36.r,
                    height: 36.r,
                    decoration: BoxDecoration(
                      color: ColorManager.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: ColorManager.white, width: 2.w),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.primary.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.location_on,
                      color: ColorManager.white,
                      size: 18.sp,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(AppPadding.p12.r),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Street 250, District 2',
                            style: getBoldStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s12.sp,
                            ),
                          ),
                          SizedBox(height: AppSize.s4.h),
                          Text(
                            'Maadi, Cairo, 11435',
                            style: getRegularStyle(
                              color: ColorManager.gray,
                              fontSize: FontSize.s11.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(AppPadding.p8.r),
                      decoration: BoxDecoration(
                        color: ColorManager.lightGray,
                        borderRadius: BorderRadius.circular(AppRadius.r10.r),
                        border: Border.all(
                          color: ColorManager.input.withValues(alpha: 0.6),
                          width: 1.w,
                        ),
                      ),
                      child: Icon(
                        Icons.directions_outlined,
                        color: ColorManager.primary,
                        size: 18.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
