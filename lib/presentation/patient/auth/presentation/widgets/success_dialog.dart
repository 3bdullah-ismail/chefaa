import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';

class SuccessDialog extends StatelessWidget {
  final String title;
  final String content;

  const SuccessDialog({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h), // Added margin
      child: AlertDialog(
        backgroundColor: ColorManager.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 25.h),
        icon: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p14),
          child: SvgPicture.asset(
            IconsAssets.doneIcon,
            height: 80.h,
            width: 80.w,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: ColorManager.black,
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        content: Container(
          constraints: BoxConstraints(
            minHeight: 100.h,
            maxHeight: 100.h,
          ),
          child: SingleChildScrollView(
            child: Text(
              content,
              style: TextStyle(
                color: ColorManager.gray,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                height: 1.5.h,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}