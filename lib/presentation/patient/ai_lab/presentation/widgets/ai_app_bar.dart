import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/values_manager.dart';

class AiAppBar extends StatelessWidget {
  final String? title1;
  final void Function()? onPressed;

  const AiAppBar({super.key, this.title1, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: ColorManager.lightGray.withValues(alpha: 20),
      elevation: 15,
      shadowColor: ColorManager.transparent,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),

      title: Padding(
        padding: const EdgeInsets.only(
          top: AppPadding.p28,
          left: AppPadding.p16,
          right: AppPadding.p16,
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title1 ?? "",
              style: getBoldStyle(
                color: ColorManager.black,
              ).copyWith(fontSize: 26),
            ),

            IconButton(
              onPressed: onPressed,
              icon: Image.asset(
                ImageAssets.historyReport,
                height: 30.h,
                width: 30.w,
                color: ColorManager.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
