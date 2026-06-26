import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';

class WorkingHoursSection extends StatelessWidget {
  final List<dynamic> workingHours;

  const WorkingHoursSection({super.key, required this.workingHours});

  @override
  Widget build(BuildContext context) {
    final currentDay = DateFormat('EEEE').format(DateTime.now());

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.access_time_rounded,
                  color: Colors.orange.shade400,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                "Working Hours",
                style: getBoldStyle(
                  color: Colors.black87,
                  fontSize: FontSize.s16.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: workingHours.length,
            separatorBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey.shade100,
              ),
            ),
            itemBuilder: (context, index) {
              final item = workingHours[index];
              final String days =
                  (item is Map ? item["days"] : null)?.toString() ?? "";
              final String time =
                  (item is Map ? item["time"] : null)?.toString() ?? "";
              
              final isToday = days.toLowerCase().contains(currentDay.toLowerCase());

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 4.w,
                        height: 24.h,
                        decoration: BoxDecoration(
                          color: isToday ? ColorManager.primary : Colors.transparent,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                      SizedBox(width: isToday ? 8.w : 12.w),
                      Text(
                        days,
                        style: getSemiBoldStyle(
                          color: isToday ? ColorManager.primary : Colors.black87,
                          fontSize: FontSize.s14.sp,
                        ),
                      ),
                      if (isToday) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: ColorManager.primary,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            "Today",
                            style: getMediumStyle(
                              color: Colors.white,
                              fontSize: FontSize.s10.sp,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  Text(
                    time,
                    style: getMediumStyle(
                      color: isToday ? Colors.black87 : Colors.grey.shade600,
                      fontSize: FontSize.s14.sp,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
