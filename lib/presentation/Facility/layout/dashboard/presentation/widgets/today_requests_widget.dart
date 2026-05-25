import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/widget/custom_text_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/routes/app_routes_names.dart';
import 'request_item_widget.dart';

class TodayRequestsWidget extends StatelessWidget {
  const TodayRequestsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "TODAY'S REQUESTS",
              style: getBoldStyle(
                color: ColorManager.gray.withValues(alpha: 0.8),
                fontSize: 12.sp,
              ).copyWith(letterSpacing: 0.5),
            ),
            CustomTextBtn(
              text: "View All",
              onPressed: () {
                Navigator.pushNamed(context, AppRoutesNames.facilityResults);
              },
            ),
          ],
        ),
        SizedBox(height: 14.h),
        const RequestItemWidget(
          name: "Sara Rashed",
          scanType: "Brain MRI",
          time: "09:30 AM",
          status: "Pending",
          aiMatchedText: "AI MATCHED",
          aiMatchedIcon: Icons.auto_awesome_rounded,
        ),
        const RequestItemWidget(
          name: "Karim Mostafa",
          scanType: "Lumber Spine MRI",
          time: "11:15 AM",
          status: "Pending",
          aiMatchedText: "AI MATCHED",
          aiMatchedIcon: Icons.flash_on_rounded,
        ),
        const RequestItemWidget(
          name: "Nour Adel",
          scanType: "Pelvic MRI",
          time: "02:00 PM",
          status: "Upcoming",
        ),
      ],
    );
  }
}
