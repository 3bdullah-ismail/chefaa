import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/values_manager.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  const SearchAppBar({super.key, this.title});

  @override
  Size get preferredSize => Size.fromHeight(AppSize.s110.h);

  @override
  Widget build(BuildContext context) {
    final bool canPop = Navigator.canPop(context);
    return AppBar(
      backgroundColor: ColorManager.input.withValues(alpha: 50),
      shadowColor: ColorManager.transparent,
      elevation: AppSize.s15,
      automaticallyImplyLeading: false,
      leading: canPop
          ? Padding(
              padding: EdgeInsets.only(left: AppPadding.p12.w),
              child: InkWell(
                borderRadius: BorderRadius.circular(AppRadius.r30),
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: AppSize.s40.w,
                  height: AppSize.s40.w,
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.black.withValues(alpha: 0.08),
                        blurRadius: AppSize.s6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: ColorManager.black,
                    size: AppSize.s20.sp,
                  ),
                ),
              ),
            )
          : null,
      centerTitle: true,
      title: Text(
        title ?? "",
        style: getBoldStyle(
          color: ColorManager.black,
          fontSize: FontSize.s26.sp,
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(AppRadius.r30),
        ),
      ),
    );
  }
}
