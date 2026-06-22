import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EarningsCard extends StatelessWidget {
  final double totalCompleted;
  final double netEarnings;

  const EarningsCard({
    super.key,
    required this.totalCompleted,
    required this.netEarnings,
  });

  String _fmt(double v) => '${v.toStringAsFixed(2)}  EGP';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: ColorManager.lightGreen,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cross Available Orders ',
                  style: getBoldStyle(
                    color: ColorManager.white,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  _fmt(totalCompleted),
                  style: getBoldStyle(
                    color: ColorManager.white,
                    fontSize: 18.sp,
                  ),
                ),
                7.verticalSpace,
                Text(
                  "Completed Orders",
                  style: getSemiBoldStyle(
                    color: ColorManager.white,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 3,
            height: 80.h,
            color: ColorManager.white.withValues(alpha: 0.3),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Net Earnings · after 1%',
                  style: getBoldStyle(
                    color: ColorManager.white,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  _fmt(netEarnings),
                  style: getBoldStyle(
                    color: ColorManager.white,
                    fontSize: 18.sp,
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
