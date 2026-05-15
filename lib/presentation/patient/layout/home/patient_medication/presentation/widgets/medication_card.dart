import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../core/resources/assets_manager.dart';
import '../../../../../../../core/resources/color_manager.dart';
import '../../../../../../../core/resources/constants_manager.dart';
import '../../../../../../../core/resources/styles_manager.dart';
import '../../data/models/Medications.dart';
import 'outline_button.dart';

class MedicationCard extends StatelessWidget {
  final List<Medications> medications;
  final int index;
  final VoidCallback onPressed;

  const MedicationCard({
    super.key,
    required this.medications,
    required this.index,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final med = medications[index];

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.lightGray,
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: ColorManager.input),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(60),
            blurRadius: 7,
            offset: const Offset(1, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.black.withAlpha(23),
                      blurRadius: 5,
                      offset: const Offset(1.5, 2),
                    ),
                  ],
                ),
                child: SvgPicture.asset(SvgAssets.medicationIcon),
              ),
              16.horizontalSpace,

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (med.name?.isNotEmpty == true)
                          ? med.name![0].toUpperCase() +
                                med.name!.substring(1).toLowerCase()
                          : "Medication Name",
                      style: getSemiBoldStyle(
                        fontSize: 18.sp,
                        color: ColorManager.black,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      "${med.dosage} - ${med.form}",
                      style: getRegularStyle(
                        color: ColorManager.h2Color,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: ColorManager.lightGreen.withAlpha(30),
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: Text(
                  "${med.adherencePercentage}%",
                  style: getBoldStyle(
                    color: ColorManager.lightGreen,
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ],
          ),

          24.verticalSpace,

          Row(
            children: [
              const Icon(Icons.access_time_rounded, color: ColorManager.gray),
              8.horizontalSpace,
              Expanded(
                child: Text(
                  "${med.timesPerDay}x daily - ${med.schedule?.join(', ') ?? ''}",
                  style: getRegularStyle(
                    color: ColorManager.gray,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),

          12.verticalSpace,

          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                color: ColorManager.gray,
              ),
              8.horizontalSpace,
              Expanded(
                child: Text(
                  "${AppConstants.formatDate(med.startDate)} - ${AppConstants.formatDate(med.endDate)}",
                  style: getRegularStyle(
                    color: ColorManager.gray,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),

          24.verticalSpace,

          Align(
            alignment: Alignment.centerRight,
            child: OutlineButton(
              onPressed: onPressed,
              title: "Edit",
              color: ColorManager.primary,
            ),
          ),
        ],
      ),
    );
  }
}
