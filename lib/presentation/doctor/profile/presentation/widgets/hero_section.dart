import 'package:chefaa/core/widget/custom_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../domain/entities/doctor_profile_entity.dart';
import 'profile_helpers.dart';

class HeroSection extends StatelessWidget {
  final DoctorProfileEntity doctor;

  const HeroSection({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.white,
      padding: EdgeInsets.fromLTRB(
        AppPadding.p16.w,
        AppPadding.p12.h,
        AppPadding.p16.w,
        AppPadding.p24.h,
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorManager.input,
                    width: AppSize.s2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.gray.withValues(alpha: 0.2),
                      blurRadius: AppSize.s8,
                      offset: const Offset(AppSize.s0, AppSize.s4),
                    ),
                  ],
                ),
                child: CustomCircleAvatar(
                  imagePath: (doctor.imageUrl ?? "").trim().isNotEmpty
                      ? doctor.imageUrl!
                      : ImageAssets.doctor,
                  radius: AppSize.s62.r,
                ),
              ),
              Positioned(
                bottom: AppSize.s8,
                right: AppSize.s8,
                child: Container(
                  padding: EdgeInsets.all(AppPadding.p6.r),
                  decoration: BoxDecoration(
                    color: ColorManager.lightGreen,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: ColorManager.white,
                      width: AppSize.s2,
                    ),
                  ),
                  child: Icon(
                    Icons.verified,
                    color: ColorManager.white,
                    size: AppSize.s14.r,
                  ),
                ),
              ),
            ],
          ),
          AppSize.s16.verticalSpace,
          Text(
            doctor.name ?? 'Dr. Sarah Johnson',
            style: getBoldStyle(
              color: ColorManager.black,
              fontSize: FontSize.s24.sp,
            ),
          ),
          AppSize.s4.verticalSpace,
          Text(
            doctor.specialization ?? 'Consultant Cardiologist',
            style: getMediumStyle(
              color: ColorManager.primary,
              fontSize: FontSize.s16.sp,
            ),
          ),
          AppSize.s8.verticalSpace,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_on_outlined,
                color: ColorManager.gray,
                size: AppSize.s18.r,
              ),
              AppSize.s4.horizontalSpace,
              Flexible(
                child: Text(
                  (doctor.location != null && doctor.location!.isNotEmpty)
                      ? doctor.location!
                      : 'Cleveland Clinic, Abu Dhabi',
                  style: getMediumStyle(
                    color: ColorManager.gray,
                    fontSize: FontSize.s12.sp,
                  ),
                ),
              ),
            ],
          ),
          AppSize.s14.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p12.w,
                  vertical: AppPadding.p8.h,
                ),
                decoration: BoxDecoration(
                  color: ColorManager.input,
                  borderRadius: BorderRadius.circular(AppRadius.r9999.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: ColorManager.lightGreen,
                      size: AppSize.s18.r,
                    ),
                    AppSize.s4.horizontalSpace,
                    Text(
                      (doctor.rating ?? 4.9).toStringAsFixed(1),
                      style: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: FontSize.s13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              AppSize.s10.horizontalSpace,
              Text(
                '(${formatReviews(doctor.reviews)} Reviews)',
                style: getRegularStyle(
                  color: ColorManager.gray,
                  fontSize: FontSize.s13.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
