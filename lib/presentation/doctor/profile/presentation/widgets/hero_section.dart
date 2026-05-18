import 'package:chefaa/core/widget/custom_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../domain/entities/doctor_profile_entity.dart';
import 'profile_helpers.dart';

class HeroSection extends StatelessWidget {
  final DoctorProfileEntity doctor;

  const HeroSection({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.white,
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorManager.input, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.gray.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: CustomCircleAvatar(
                  imagePath: (doctor.imageUrl ?? "").trim().isNotEmpty
                      ? doctor.imageUrl!
                      : ImageAssets.doctor,
                  radius: 62.r,
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.all(6.r),
                  decoration: BoxDecoration(
                    color: ColorManager.lightGreen,
                    shape: BoxShape.circle,
                    border: Border.all(color: ColorManager.white, width: 2),
                  ),
                  child: Icon(
                    Icons.verified,
                    color: ColorManager.white,
                    size: 14.r,
                  ),
                ),
              ),
            ],
          ),
          16.verticalSpace,
          Text(
            doctor.name ?? 'Dr. Sarah Johnson',
            style: getBoldStyle(color: ColorManager.black, fontSize: 24.sp),
          ),
          4.verticalSpace,
          Text(
            doctor.specialization ?? 'Consultant Cardiologist',
            style: getMediumStyle(color: ColorManager.primary, fontSize: 16.sp),
          ),
          8.verticalSpace,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_on_outlined,
                color: ColorManager.gray,
                size: 18.r,
              ),
              4.horizontalSpace,
              Flexible(
                child: Text(
                  (doctor.location != null && doctor.location!.isNotEmpty)
                      ? doctor.location!
                      : 'Cleveland Clinic, Abu Dhabi',
                  style: getMediumStyle(
                    color: ColorManager.gray,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
          14.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: ColorManager.input,
                  borderRadius: BorderRadius.circular(9999.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: ColorManager.lightGreen,
                      size: 18.r,
                    ),
                    4.horizontalSpace,
                    Text(
                      (doctor.rating ?? 4.9).toStringAsFixed(1),
                      style: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              10.horizontalSpace,
              Text(
                '(${formatReviews(doctor.reviews)} Reviews)',
                style: getRegularStyle(
                  color: ColorManager.gray,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
