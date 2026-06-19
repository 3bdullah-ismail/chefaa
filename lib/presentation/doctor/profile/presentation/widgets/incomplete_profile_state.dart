import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import 'missing_field_chip.dart';

class IncompleteProfileState extends StatelessWidget {
  final List<String> missingFields;
  final VoidCallback onCompleteProfile;

  const IncompleteProfileState({
    super.key,
    required this.missingFields,
    required this.onCompleteProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppPadding.p24.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppRadius.r24.r),
        border: Border.all(color: ColorManager.input),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.08),
            blurRadius: AppSize.s20,
            offset: const Offset(AppSize.s0, AppSize.s8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: AppSize.s84.r,
            height: AppSize.s84.r,
            decoration: const BoxDecoration(
              color: ColorManager.lightBlue,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person_outline,
              color: ColorManager.primary,
              size: AppSize.s42.r,
            ),
          ),
          AppSize.s20.verticalSpace,
          Text(
            'Complete your profile first',
            style: getBoldStyle(
              color: ColorManager.black,
              fontSize: FontSize.s20.sp,
            ),
          ),
          AppSize.s10.verticalSpace,
          Text(
            'Your profile is missing a few required details. Please complete them to continue.',
            textAlign: TextAlign.center,
            style: getRegularStyle(
              color: ColorManager.gray,
              fontSize: FontSize.s14.sp,
            ),
          ),
          AppSize.s20.verticalSpace,
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              'Missing information',
              style: getBoldStyle(
                color: ColorManager.black,
                fontSize: FontSize.s14.sp,
              ),
            ),
          ),
          AppSize.s12.verticalSpace,
          Wrap(
            spacing: AppSize.s8.w,
            runSpacing: AppSize.s8.h,
            children: missingFields.isEmpty
                ? [const MissingFieldChip(label: 'Profile data not completed')]
                : missingFields
                      .map((field) => MissingFieldChip(label: field))
                      .toList(),
          ),
          AppSize.s24.verticalSpace,
          SizedBox(
            width: double.infinity,
            height: AppSize.s54.h,
            child: ElevatedButton(
              onPressed: onCompleteProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primary,
                foregroundColor: ColorManager.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.r16.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Complete Profile',
                style: getBoldStyle(
                  color: ColorManager.white,
                  fontSize: FontSize.s14.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
