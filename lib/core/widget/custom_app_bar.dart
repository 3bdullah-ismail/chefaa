import 'package:chefaa/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import 'custom_circle_avatar.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isLayout;
  final String? title1;
  final String? title2;
  final void Function()? onPressed;

  const CustomAppBar({
    super.key,
    this.isLayout = false,
    this.title1,
    this.title2,
    this.onPressed,
  });

  @override
  Size get preferredSize => Size.fromHeight(110.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: ColorManager.primary,
      shadowColor: ColorManager.black.withValues(alpha: .25),
      elevation: 15,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 30.sp,
            left: isLayout ? 20.sp : 50.sp,
            right: 20.sp,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isLayout
                  ? Row(
                      children: [
                        CustomCircleAvatar(
                          imagePath: ImageAssets.patient,
                          radius: 35.r,
                        ),
                        20.horizontalSpace,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title1 ?? "",
                              style: const TextStyle(
                                color: ColorManager.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            7.verticalSpace,
                            Text(
                              title2 ?? "",
                              style: const TextStyle(
                                color: ColorManager.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Image.asset("assets/images/chefaa.png", height: 50.h),

              if (isLayout)
                IconButton(
                  onPressed: onPressed,
                  icon: Container(
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
                ),
            ],
          ),
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
    );
  }
}
