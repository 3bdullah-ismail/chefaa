import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';

class EmptyNotificationState extends StatelessWidget {
  const EmptyNotificationState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none_rounded,
              size: 80.sp,
              color: ColorManager.primary,
            ),
            20.verticalSpace,
            Text(
              "No Notifications",
              style: getBoldStyle(
                color: ColorManager.black,
                fontSize: 18.sp,
              ),
            ),
            8.verticalSpace,
            Text(
              "You're all caught up.\nNew notifications will appear here.",
              textAlign: TextAlign.center,
              style: getMediumStyle(
                color: ColorManager.gray,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}