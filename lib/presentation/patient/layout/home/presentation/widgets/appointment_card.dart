import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/widget/custom_btn.dart';
import 'package:chefaa/core/widget/custom_outline_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/values_manager.dart';
import '../../../search/domain/entities/doctor_clinic.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 230.h,
      padding: const EdgeInsets.all(AppPadding.p18),
      decoration: BoxDecoration(
        color: ColorManager.lightGray,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(color: ColorManager.black.withAlpha(80), blurRadius: 10),
        ],
      ),
      child: Column(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "DR.Ahmed Ali",
                    style: getMediumStyle(
                      color: ColorManager.black,
                      fontSize: 20,
                    ),
                  ),
                  7.verticalSpace,

                  Text(
                    "Specialized Psychiatrist",
                    style: getSemiBoldStyle(
                      color: ColorManager.gray,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          20.verticalSpace,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: ColorManager.gray,
                  size: 25.sp,
                ),
                12.horizontalSpace,
                Text(
                  "11 Feb 2026 – 10:45 AM",
                  style: getSemiBoldStyle(
                    color: ColorManager.gray,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          20.verticalSpace,
          Row(
            children: [
              const CustomOutlineBtn(title: "Decline", color: ColorManager.error),
              13.horizontalSpace,
              const   CustomOutlineBtn(
                title: "Reschedule",
                color: ColorManager.primary,
              ),
              13.horizontalSpace,
              CustomBtn(isSmall: true,text: "Join Now", onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
