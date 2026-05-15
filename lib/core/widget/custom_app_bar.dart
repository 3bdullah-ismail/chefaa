import 'package:chefaa/core/resources/assets_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/core/widget/custom_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/color_manager.dart';

class CustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Widget child;
  final Color? backgroundColor;
  final double? elevation;
  final double? preferredHeight;
  final EdgeInsets? padding;
  final double? borderRadiusValue;

  const CustomAppBar({
    super.key,
    required this.child,
    this.backgroundColor,
    this.elevation,
    this.preferredHeight,
    this.padding,
    this.borderRadiusValue,
  });

  factory CustomAppBar.layout({
    Key? key,
    required String title1,
    required String title2,
    VoidCallback? onPressed,
  }) {
    return CustomAppBar(
      key: key,
      padding: EdgeInsets.only(
        top: 30.sp,
        left: 20.sp,
        right: 20.sp,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
    );
  }

  factory CustomAppBar.logo({
    Key? key,
  }) {
    return CustomAppBar(
      key: key,
      padding: EdgeInsets.only(
        top: 30.sp,
        left: 50.sp,
        right: 20.sp,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Image.asset(
          "assets/images/chefaa.png",
          height: 50.h,
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(preferredHeight ?? 110.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      backgroundColor: backgroundColor ?? ColorManager.primary,
      shadowColor: ColorManager.black.withValues(alpha: .25),
      elevation: elevation ?? 15,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: padding ??
              EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 14.h,
              ),
          child: child,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(
            borderRadiusValue ?? 30.r,
          ),
        ),
      ),
    );
  }
}