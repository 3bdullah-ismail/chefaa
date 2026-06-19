import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/resources/styles_manager.dart';

class ServicesAiInsightWidget extends StatelessWidget {
  const ServicesAiInsightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF5FF),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFF3E8FF),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.auto_awesome_rounded,
                color: const Color(0xFF7E22CE),
                size: 14.sp,
              ),
              SizedBox(width: 6.w),
              Text(
                "AI INSIGHT",
                style: getBoldStyle(
                  color: const Color(0xFF7E22CE),
                  fontSize: 10.sp,
                ).copyWith(letterSpacing: 0.5),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            "Most requested this week",
            style: getBoldStyle(
              color: const Color(0xFF581C87),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            "HbA1c screenings have increased by 24%. Consider updating your availability for the coming weekend to handle the surge.",
            style: getRegularStyle(
              color: const Color(0xFF6B21A8),
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }
}
