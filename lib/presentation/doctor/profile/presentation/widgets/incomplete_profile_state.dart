import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
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
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: ColorManager.black.withValues(alpha: 0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 84.r,
                height: 84.r,
                decoration: const BoxDecoration(
                  color: ColorManager.lightBlue,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_outline,
                  color: ColorManager.primary,
                  size: 42.r,
                ),
              ),
              20.verticalSpace,
              Text(
                'Complete your profile first',
                style: getBoldStyle(color: ColorManager.black, fontSize: 20.sp),
              ),
              10.verticalSpace,
              Text(
                'Your profile is missing a few required details. Please complete them to continue.',
                textAlign: TextAlign.center,
                style: getRegularStyle(
                  color: ColorManager.gray,
                  fontSize: 14.sp,
                ),
              ),
              20.verticalSpace,
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'Missing information',
                  style: getBoldStyle(
                    color: ColorManager.black,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              12.verticalSpace,
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: missingFields.isEmpty
                    ? [
                        const MissingFieldChip(
                          label: 'Profile data not completed',
                        ),
                      ]
                    : missingFields
                          .map((field) => MissingFieldChip(label: field))
                          .toList(),
              ),
              24.verticalSpace,
              SizedBox(
                width: double.infinity,
                height: 54.h,
                child: ElevatedButton(
                  onPressed: onCompleteProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    foregroundColor: ColorManager.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Complete Profile',
                    style: getBoldStyle(
                      color: ColorManager.white,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
