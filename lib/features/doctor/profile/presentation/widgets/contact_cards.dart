import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/features/doctor/profile/domain/entities/doctor_profile_entity.dart';

class ContactCards extends StatelessWidget {
  final DoctorProfileEntity doctor;

  const ContactCards({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final phone = doctor.contactNumber ?? '+971 2 123 4567';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
      child: Container(
        padding: EdgeInsets.all(AppPadding.p16.w),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(AppRadius.r18.r),
          border: Border.all(color: ColorManager.input),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(AppPadding.p10.r),
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withValues(alpha: 0.10),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.phone,
                    color: ColorManager.primary,
                    size: AppSize.s20.r,
                  ),
                ),
                AppSize.s14.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " Phone",
                      style: getMediumStyle(
                        color: ColorManager.gray,
                        fontSize: FontSize.s12.sp,
                      ),
                    ),
                    AppSize.s4.verticalSpace,
                    Text(
                      phone,
                      style: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: FontSize.s14.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: ColorManager.gray,
              size: AppSize.s18.r,
            ),
          ],
        ),
      ),
    );
  }
}
