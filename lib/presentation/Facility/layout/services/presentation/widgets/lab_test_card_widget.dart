import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabTestCardWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String price;
  final String duration;
  final bool isSwitchedOn;
  final ValueChanged<bool> onSwitchChanged;
  final String? badgeText;

  const LabTestCardWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.duration,
    required this.isSwitchedOn,
    required this.onSwitchChanged,
    this.badgeText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: ColorManager.input.withValues(alpha: 0.8),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: ColorManager.lightBlue.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, color: ColorManager.primary, size: 20.sp),
              ),
              CupertinoSwitch(
                value: isSwitchedOn,
                activeTrackColor: ColorManager.primary,
                onChanged: onSwitchChanged,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Text(
                title,
                style: getBoldStyle(color: ColorManager.black, fontSize: 14.sp),
              ),
              if (badgeText != null) ...[
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD1FAE5),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    badgeText!,
                    style: getBoldStyle(
                      color: const Color(0xFF065F46),
                      fontSize: 9.sp,
                    ),
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            subtitle,
            style: getRegularStyle(color: ColorManager.gray, fontSize: 11.sp),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price',
                    style: getRegularStyle(
                      color: ColorManager.gray,
                      fontSize: 10.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    price,
                    style: getBoldStyle(
                      color: ColorManager.black,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Duration',
                    style: getRegularStyle(
                      color: ColorManager.gray,
                      fontSize: 10.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    duration,
                    style: getBoldStyle(
                      color: ColorManager.black,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
