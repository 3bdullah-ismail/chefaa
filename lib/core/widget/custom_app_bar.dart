import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import 'custom_circle_avatar.dart';

class CustomAppBar extends StatelessWidget {
  final bool isLayout;
  final String? title1;
  final String? title2;
  final void Function()? onPressed;
  final bool isSingleTitle;

  const CustomAppBar({
    this.isSingleTitle = false,
    super.key,
    this.isLayout = false,
    this.title1,
    this.title2,
    this.onPressed,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: isSingleTitle
          ? ColorManager.input.withValues(alpha: 50)
          : ColorManager.primary,
      shadowColor: isSingleTitle
          ? ColorManager.transparent
          : ColorManager.black.withValues(alpha: .25),
      elevation: 15,

      flexibleSpace: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 30.sp, left: isLayout ? 20.sp : 50.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isLayout
                  ? isSingleTitle
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppPadding.p18,
                            ),
                            child: Text(
                              title1 ?? "",
                              style: getBoldStyle(
                                color: ColorManager.black,
                              ).copyWith(fontSize: 26),
                            ),
                          )
                        : Row(
                            children: [
                              CustomCircleAvatar(
                                imagePath: ImageAssets.patient,
                                radius: 50.r,
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

              if (isLayout & !isSingleTitle)
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
                      height: 30.h,
                      width: 30.w,
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
