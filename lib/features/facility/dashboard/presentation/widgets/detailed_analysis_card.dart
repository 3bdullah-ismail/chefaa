import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/core/widgets/custom_circle_avatar.dart';
import 'package:chefaa/features/facility/dashboard/data/models/patient_detail_data.dart';

class DetailedAnalysisCard extends StatelessWidget {
  final PatientDetailData detail;

  const DetailedAnalysisCard({super.key, required this.detail});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppPadding.p16.r),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppRadius.r20.r),
        border: Border.all(color: ColorManager.input.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomCircleAvatar(
                imagePath: ImageAssets.patient,
                radius: AppRadius.r22.r,
              ),
              SizedBox(width: AppSize.s12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      detail.name,
                      style: getBoldStyle(
                        color: ColorManager.slate900,
                        fontSize: FontSize.s14.sp,
                      ),
                    ),
                    SizedBox(height: AppSize.s2.h),
                    Text(
                      "ID: ${detail.id} • ${detail.details}",
                      style: getMediumStyle(
                        color: ColorManager.gray,
                        fontSize: FontSize.s11.sp,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: ColorManager.gray,
                ),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),

          SizedBox(height: AppSize.s12.h),

          Wrap(
            spacing: AppSize.s8.w,
            runSpacing: AppSize.s6.h,
            children: detail.badges.map((badge) {
              final isUrgent =
                  badge == "URGENT REVIEW" || badge == "REVIEW PENDING";
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p10.w,
                  vertical: AppPadding.p4.h,
                ),
                decoration: BoxDecoration(
                  color: isUrgent ? ColorManager.mint100 : ColorManager.blue100,
                  borderRadius: BorderRadius.circular(AppRadius.r6.r),
                ),
                child: Text(
                  badge,
                  style: getBoldStyle(
                    color: isUrgent
                        ? ColorManager.mint600
                        : ColorManager.blue700,
                    fontSize: FontSize.s9.sp,
                  ),
                ),
              );
            }).toList(),
          ),

          SizedBox(height: AppSize.s20.h),

          Row(
            children: [
              Icon(
                Icons.description_outlined,
                color: ColorManager.indigo800,
                size: FontSize.s16.sp,
              ),
              SizedBox(width: AppSize.s8.w),
              Text(
                "Doctor's Notes",
                style: getBoldStyle(
                  color: ColorManager.indigo800,
                  fontSize: FontSize.s12.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSize.s8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppPadding.p12.r),
            decoration: BoxDecoration(
              color: ColorManager.lightBlue100,
              borderRadius: BorderRadius.circular(AppRadius.r12.r),
              border: Border.all(color: ColorManager.blue100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detail.doctorNotes,
                  style: getRegularStyle(
                    color: ColorManager.slate900,
                    fontSize: FontSize.s11_5.sp,
                  ),
                ),
                SizedBox(height: AppSize.s12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "— ${detail.doctorName}",
                      style: getBoldStyle(
                        color: ColorManager.darkGray,
                        fontSize: FontSize.s10_5.sp,
                      ),
                    ),
                    Text(
                      detail.doctorNotesTime,
                      style: getRegularStyle(
                        color: ColorManager.gray,
                        fontSize: FontSize.s10.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: AppSize.s20.h),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: ColorManager.purple100, width: 1.5.w),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.violet600.withValues(alpha: 0.03),
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
                    Icon(
                      Icons.auto_awesome_outlined,
                      color: ColorManager.violet600,
                      size: FontSize.s16.sp,
                    ),
                    SizedBox(width: AppSize.s8.w),
                    Text(
                      "AI Health Insight",
                      style: getBoldStyle(
                        color: ColorManager.violet600,
                        fontSize: FontSize.s12.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSize.s8.h),
                Text(
                  detail.aiInsight,
                  style: getRegularStyle(
                    color: ColorManager.gray600,
                    fontSize: FontSize.s11_5.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(AppPadding.p6.r),
                      decoration: const BoxDecoration(
                        color: ColorManager.purple100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.receipt_long_outlined,
                        size: FontSize.s14.sp,
                        color: ColorManager.violet600,
                      ),
                    ),
                    SizedBox(width: AppSize.s8.w),
                    Container(
                      padding: EdgeInsets.all(AppPadding.p6.r),
                      decoration: const BoxDecoration(
                        color: ColorManager.purple100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.map_outlined,
                        size: FontSize.s14.sp,
                        color: ColorManager.violet600,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Navigating to ${detail.aiLinkText}...",
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            detail.aiLinkText,
                            style: getBoldStyle(
                              color: ColorManager.violet600,
                              fontSize: FontSize.s11.sp,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right_rounded,
                            size: FontSize.s14.sp,
                            color: ColorManager.violet600,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

