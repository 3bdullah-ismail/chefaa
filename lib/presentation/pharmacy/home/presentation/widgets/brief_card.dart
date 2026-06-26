import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatCard extends StatelessWidget {
  final String label;
  final String value;

  const StatCard({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: ColorManager.lightGray,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: ColorManager.lightGray, width: 1),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(50),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 8.h),
          Text(
            value,
            style: getBoldStyle(color: ColorManager.black, fontSize: 16.sp),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: getBoldStyle(color: ColorManager.darkGray, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
