import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/widget/custom_btn.dart';
import 'package:chefaa/core/widget/custom_outline_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/values_manager.dart';

class DoctorCard extends StatelessWidget {
  final bool isAppointments;

  const DoctorCard({super.key, this.isAppointments = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: 200.h),
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p12,
        vertical: AppPadding.p16,
      ),
      decoration: BoxDecoration(
        color: ColorManager.lightGray,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(80),
            blurRadius: isAppointments ? 1 : 10,
            offset: isAppointments ? const Offset(0, 3) : const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: const Icon(Icons.person, color: ColorManager.white),
              ),
              15.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "DR.Ahmed Ali",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: getMediumStyle(
                        color: ColorManager.black,
                        fontSize: 20,
                      ),
                    ),
                    7.verticalSpace,

                    Text(
                      "Specialized Psychiatrist",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: getSemiBoldStyle(
                        color: ColorManager.gray,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          10.verticalSpace,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: ColorManager.gray,
                  size: 20.sp,
                ),
                12.horizontalSpace,
                Expanded(
                  child: Text(
                    "11 Feb 2026 – 10:45 AM",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: getSemiBoldStyle(
                      color: ColorManager.gray,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          10.verticalSpace,
          Row(
            children: [
              const CustomOutlineBtn(
                title: "Decline",
                color: ColorManager.error,
              ),
              5.horizontalSpace,
              const CustomOutlineBtn(
                title: "Reschedule",
                color: ColorManager.primary,
              ),
              5.horizontalSpace,
              CustomBtn(text: "Join Now", onPressed: () {}, isSmall: true),
            ],
          ),
        ],
      ),
    );
  }
}
