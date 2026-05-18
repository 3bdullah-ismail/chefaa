import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../domain/entities/doctor_profile_entity.dart';

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
      height: 48.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: chips.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(9999.r),
            border: Border.all(color: ColorManager.primary),
          ),
          child: Text(
            chips[index],
            style: getMediumStyle(color: ColorManager.primary, fontSize: 13.sp),
          ),
        ),
      ),
    );
  }
}
