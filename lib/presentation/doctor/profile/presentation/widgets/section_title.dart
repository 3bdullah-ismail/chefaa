import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/values_manager.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppPadding.p16.w,
        AppPadding.p20.h,
        AppPadding.p16.w,
        AppPadding.p12.h,
      ),
      child: Text(
        title,
        style: getBoldStyle(
          color: ColorManager.black,
          fontSize: FontSize.s18.sp,
        ),
      ),
    );
  }
}
