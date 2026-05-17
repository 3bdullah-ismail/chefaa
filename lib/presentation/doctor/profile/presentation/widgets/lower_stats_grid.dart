import 'package:chefaa/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../patient/profile/presentation/widgets/item_container.dart';
import 'profile_stat_item.dart';

class LowerStatsGrid extends StatelessWidget {
  const LowerStatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return ItemContainer(
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
