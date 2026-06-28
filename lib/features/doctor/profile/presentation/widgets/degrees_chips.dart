import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/features/doctor/profile/domain/entities/doctor_profile_entity.dart';

class DegreesChips extends StatelessWidget {
  final DoctorProfileEntity doctor;

  const DegreesChips({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final degrees = (doctor.degrees ?? const [])
        .whereType<dynamic>()
        .map((e) => e.toString())
        .where((e) => e.trim().isNotEmpty)
        .toList();
    final chips = degrees.isEmpty
        ? [
            'MD in Cardiology',
            'Fellowship @ Mayo Clinic',
            'American Board Certified',
            'ESC Member',
          ]
        : degrees;

    return SizedBox(
      height: AppSize.s48.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
        itemCount: chips.length,
        separatorBuilder: (context, index) => SizedBox(width: AppSize.s8.w),
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.p16.w,
            vertical: AppPadding.p10.h,
          ),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(AppRadius.r9999.r),
            border: Border.all(color: ColorManager.primary),
          ),
          child: Text(
            chips[index],
            style: getMediumStyle(
              color: ColorManager.primary,
              fontSize: FontSize.s13.sp,
            ),
          ),
        ),
      ),
    );
  }
}
