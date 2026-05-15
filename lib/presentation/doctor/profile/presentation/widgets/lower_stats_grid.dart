import 'package:chefaa/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'profile_stat_item.dart';

class LowerStatsGrid extends StatelessWidget {
  const LowerStatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildStatItem("8", "Patients", Icons.people, ColorManager.black),
              _buildStatItem(
                "5",
                "Done",
                Icons.check_box,
                ColorManager.lightGreen,
              ),
            ],
          ),
          16.verticalSpace,
          Row(
            children: [
              _buildStatItem(
                "3",
                "Upcoming",
                Icons.hourglass_bottom,
                ColorManager.lawAnalysis,
              ),
              _buildStatItem(
                "3",
                "Unread",
                Icons.chat_bubble_outline,
                ColorManager.cyan,
              ),
            ],
          ),
          const Divider(height: 32, thickness: 1, color: ColorManager.input),
          const ProfileStatItem(
            value: "0",
            label: "Rating",
            textColor: ColorManager.black,
            icon: Icon(Icons.star_border, color: ColorManager.gold, size: 35),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String val, String lab, IconData icon, Color color) {
    return Expanded(
      child: ProfileStatItem(
        value: val,
        label: lab,
        textColor: ColorManager.black,
        icon: Icon(icon, color: color, size: 24.sp),
      ),
    );
  }
}
