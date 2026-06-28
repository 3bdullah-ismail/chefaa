import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/features/doctor/profile/domain/entities/doctor_profile_entity.dart';
import 'profile_helpers.dart';
import 'stat_card.dart';

class QuickStatsRow extends StatelessWidget {
  final DoctorProfileEntity doctor;

  const QuickStatsRow({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppPadding.p16.w,
        AppSize.s0,
        AppPadding.p16.w,
        AppPadding.p20.h,
      ),
      child: SizedBox(
        height: AppSize.s92.h,
        child: Row(
          children: [
            Expanded(
              child: StatCard(
                label: 'Clinics',

                value: '${doctor.clinics ?? 0}',
                icon: Icons.home_work_outlined,
              ),
            ),
            SizedBox(width: AppSize.s10.w),
            const Expanded(
              child: StatCard(
                label: 'Score',

                value: '98%',
                icon: Icons.thumb_up_alt_outlined,
              ),
            ),
            SizedBox(width: AppSize.s10.w),
            Expanded(
              child: StatCard(
                label: 'Reviews',

                value: formatReviews(doctor.reviews),
                icon: Icons.forum_outlined,
              ),
            ),
            SizedBox(width: AppSize.s10.w),
            Expanded(
              child: StatCard(
                label: 'Years',
                value: '${doctor.yearsOfExperience ?? 0}+',
                icon: Icons.event_available_outlined,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
