import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileStatsSection extends StatelessWidget {
  final num? rating;
  final num? servicesCount;

  const ProfileStatsSection({super.key, this.rating, this.servicesCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: 'RATING',
            valueChild: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  rating?.toString() ?? '4.8',
                  style: getBoldStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s16.sp,
                  ),
                ),
                SizedBox(width: AppSize.s4.w),
                Icon(Icons.star_rounded, color: ColorManager.gold, size: 16.sp),
              ],
            ),
          ),
        ),
        SizedBox(width: AppSize.s12.w),
        Expanded(
          child: _StatCard(
            label: 'SERVICES',
            valueChild: Text(
              servicesCount?.toString() ?? '42',
              style: getBoldStyle(
                color: ColorManager.black,
                fontSize: FontSize.s16.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final Widget valueChild;

  const _StatCard({required this.label, required this.valueChild});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppRadius.r16.r),
        border: Border.all(
          color: ColorManager.input.withValues(alpha: 0.8),
          width: 1.w,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: getBoldStyle(
              color: ColorManager.gray,
              fontSize: FontSize.s10.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSize.s6.h),
          valueChild,
        ],
      ),
    );
  }
}
