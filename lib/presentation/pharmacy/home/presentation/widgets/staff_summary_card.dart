import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StaffSummaryCard extends StatelessWidget {
  final int available;
  final int busy;
  final int total;

  const StaffSummaryCard({
    super.key,
    required this.available,
    required this.busy,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: ColorManager.lightGray),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(80),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          _StaffMetric(
            label: 'Available',
            value: available,
            color: ColorManager.lightGreen,
          ),
          10.horizontalSpace,
          _StaffMetric(label: 'Busy', value: busy, color: ColorManager.error),
          10.horizontalSpace,
          _StaffMetric(
            label: 'Total',
            value: total,
            color: ColorManager.primary,
          ),
        ],
      ),
    );
  }
}

class _StaffMetric extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _StaffMetric({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            '$value',
            style: getBoldStyle(color: color, fontSize: 18.sp),
          ),
          7.verticalSpace,
          Text(
            label,
            style: getSemiBoldStyle(
              color: ColorManager.darkGray,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
