import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import 'mini_action_button.dart';

class LocationCard extends StatelessWidget {
  final String title, address, statusLabel;
  final bool isPrimary, subdued;

  const LocationCard({
    super.key,
    required this.title,
    required this.address,
    required this.statusLabel,
    required this.isPrimary,
    this.subdued = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: subdued
            ? ColorManager.white.withValues(alpha: 0.88)
            : ColorManager.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: ColorManager.input),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: getBoldStyle(
                    color: ColorManager.black,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: isPrimary
                      ? ColorManager.lightGreen.withValues(alpha: 0.12)
                      : ColorManager.input,
                  borderRadius: BorderRadius.circular(9999.r),
                ),
                child: Text(
                  statusLabel,
                  style: getBoldStyle(
                    color: isPrimary
                        ? ColorManager.lightGreen
                        : ColorManager.gray,
                    fontSize: 10.sp,
                  ),
                ),
              ),
            ],
          ),
          12.verticalSpace,
          Row(
            children: [
              const Icon(Icons.location_on_outlined, color: ColorManager.gray),
              8.horizontalSpace,
              Expanded(
                child: Text(
                  address,
                  style: getRegularStyle(
                    color: ColorManager.gray,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ],
          ),
          12.verticalSpace,
          Row(
            children: [
              const Icon(Icons.schedule_outlined, color: ColorManager.gray),
              8.horizontalSpace,
              Text(
                'Mon - Fri: 09:00 AM - 05:00 PM',
                style: getMediumStyle(
                  color: ColorManager.darkGray,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          16.verticalSpace,
          Row(
            children: [
              Expanded(
                child: MiniActionButton(
                  icon: Icons.phone_outlined,
                  label: 'Call',
                ),
              ),
              8.horizontalSpace,
              Expanded(
                child: MiniActionButton(
                  icon: Icons.near_me_outlined,
                  label: 'Navigate',
                ),
              ),
              8.horizontalSpace,
              Expanded(
                child: MiniActionButton(
                  icon: Icons.calendar_month_outlined,
                  label: 'Book',
                  filled: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
