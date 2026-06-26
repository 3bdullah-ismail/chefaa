import 'package:chefaa/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';
import 'clinic_performance_card.dart';

class PerClinicCard extends StatelessWidget {
  final List<ClinicPerformanceCard> clinics;

  const PerClinicCard({super.key, required this.clinics});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(80),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Per Clinic",
            style: getBoldStyle(
              color: ColorManager.black,
              fontSize: 16.sp,
            )
          ),
          ...clinics,
        ],
      ),
    );
  }
}