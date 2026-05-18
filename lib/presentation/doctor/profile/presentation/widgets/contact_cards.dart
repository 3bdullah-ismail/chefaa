import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../domain/entities/doctor_profile_entity.dart';

class ContactCards extends StatelessWidget {
  final DoctorProfileEntity doctor;

  const ContactCards({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final phone = doctor.contactNumber ?? '+971 2 123 4567';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: ColorManager.input),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withValues(alpha: 0.10),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.phone,
                    color: ColorManager.primary,
                    size: 20.r,
                  ),
                ),
                14.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " Phone",
                      style: getMediumStyle(
                        color: ColorManager.gray,
                        fontSize: 12.sp,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      phone,
                      style: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios, color: ColorManager.gray, size: 18.r),
          ],
        ),
      ),
    );
  }
}
