import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'custom_app_bar.dart';
import 'custom_circle_avatar.dart';

class CustomAppBarLayout extends StatelessWidget {
  final String title1;
  final String title2;
  final VoidCallback? onPressed;
  final bool hasUnreadNotifications;

  const CustomAppBarLayout({
    super.key,
    required this.title1,
    required this.title2,
    this.onPressed,
    this.hasUnreadNotifications = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      padding: EdgeInsets.only(top: 30.sp, left: 20.sp, right: 20.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CustomCircleAvatar(imagePath: ImageAssets.patient, radius: 35.r),

              20.horizontalSpace,

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title1,
                    style: const TextStyle(
                      color: ColorManager.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  7.verticalSpace,

                  Text(
                    title2,
                    style: const TextStyle(
                      color: ColorManager.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),

          IconButton(
            onPressed: onPressed,
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppPadding.p10),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: SvgPicture.asset(
                    IconsAssets.notification,
                    height: 20.h,
                    width: 20.w,
                  ),
                ),

                if (hasUnreadNotifications)
                  Container(
                    padding: const EdgeInsets.all(AppPadding.p10),
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: SvgPicture.asset(
                      IconsAssets.notificationFull,
                      height: 20.h,
                      width: 20.w,
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
