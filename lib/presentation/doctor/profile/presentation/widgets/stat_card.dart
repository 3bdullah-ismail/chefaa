import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/values_manager.dart';

class StatCard extends StatelessWidget {
  final String label, value;
  final IconData icon;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.s92.w,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppRadius.r16.r),
        border: Border.all(color: ColorManager.input),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: ColorManager.lightGreen, size: AppSize.s22.r),
          AppSize.s6.verticalSpace,
          Text(
            value,
            style: getBoldStyle(
              color: ColorManager.black,
              fontSize: FontSize.s18.sp,
            ),
          ),
          AppSize.s2.verticalSpace,
          Text(
            label,
            style: getRegularStyle(
              color: ColorManager.gray,
              fontSize: FontSize.s11.sp,
            ),
          ),
        ],
      ),
    );
  }
}
