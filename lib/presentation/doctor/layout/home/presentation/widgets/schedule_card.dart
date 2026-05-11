import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScheduleCard extends StatelessWidget {
  final String day;
  final String time;

  const ScheduleCard({super.key, required this.day, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      decoration: BoxDecoration(
        color: ColorManager.input.withAlpha(100),
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p18,
          vertical: AppPadding.p12,
        ),
        child: Row(
          children: [
            Text(
              day,
              style: getBoldStyle(color: ColorManager.gray, fontSize: 18),
            ),
            15.horizontalSpace,
            Text(time, style: getSemiBoldStyle(color: ColorManager.gray)),
          ],
        ),
      ),
    );
  }
}
