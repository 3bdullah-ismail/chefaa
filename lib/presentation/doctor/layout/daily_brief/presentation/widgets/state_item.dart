import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';

class StatItem extends StatelessWidget {
  final String title;
  final String value;

  const StatItem({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: getBoldStyle(
            fontSize: 16.sp, color: ColorManager.black,
          ),
        ),
        5.verticalSpace,
        Text(
          title,
          textAlign: TextAlign.center,
          style: getRegularStyle(
            fontSize: 14.sp, color: ColorManager.gray,
          ),
        ),
      ],
    );
  }
}