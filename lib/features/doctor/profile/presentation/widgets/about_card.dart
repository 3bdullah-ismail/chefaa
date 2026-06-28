import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/features/doctor/profile/domain/entities/doctor_profile_entity.dart';

class AboutCard extends StatefulWidget {
  final DoctorProfileEntity doctor;

  const AboutCard({super.key, required this.doctor});

  @override
  State<AboutCard> createState() => _AboutCardState();
}

class _AboutCardState extends State<AboutCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final about =
        widget.doctor.about ??
        'Dr. Sarah Johnson is a distinguished Consultant Cardiologist with over 15 years of experience.';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p16.w),
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.lightBlue,
          borderRadius: BorderRadius.circular(AppRadius.r18.r),
        ),
        padding: EdgeInsets.all(AppPadding.p16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              about,
              maxLines: _expanded ? null : 4,
              overflow: _expanded
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
              style: getRegularStyle(
                color: ColorManager.darkGray,
                fontSize: FontSize.s14.sp,
              ),
            ),
            AppSize.s8.verticalSpace,
            GestureDetector(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Text(
                _expanded ? 'Show less' : 'Read more',
                style: getMediumStyle(
                  color: ColorManager.primary,
                  fontSize: FontSize.s13.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
