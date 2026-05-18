import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import 'stat_data.dart';

class StatCard extends StatelessWidget {
  final StatData data;

  const StatCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92.w,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorManager.input),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(data.icon, color: ColorManager.lightGreen, size: 22.r),
          6.verticalSpace,
          Text(
            data.value,
            style: getBoldStyle(color: ColorManager.black, fontSize: 18.sp),
          ),
          2.verticalSpace,
          Text(
            data.label,
            style: getRegularStyle(color: ColorManager.gray, fontSize: 11.sp),
          ),
        ],
      ),
    );
  }
}
