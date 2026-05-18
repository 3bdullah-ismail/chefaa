import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/doctor_profile_entity.dart';
import 'profile_helpers.dart';
import 'stat_card.dart';
import 'stat_data.dart';

class QuickStatsRow extends StatelessWidget {
  final DoctorProfileEntity doctor;

  const QuickStatsRow({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final items = [
      StatData('Clinics', '${doctor.clinics ?? 0}', Icons.home_work_outlined),
      StatData('Score', '98%', Icons.thumb_up_alt_outlined),
      StatData('Reviews', formatReviews(doctor.reviews), Icons.forum_outlined),
      StatData(
        'Years',
        '${doctor.yearsOfExperience ?? 0}+',
        Icons.event_available_outlined,
      ),
    ];

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
      child: SizedBox(
        height: 92.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          separatorBuilder: (_, __) => SizedBox(width: 10.w),
          itemBuilder: (context, index) => StatCard(data: items[index]),
        ),
      ),
    );
  }
}
