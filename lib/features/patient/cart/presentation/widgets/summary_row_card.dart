import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';

class SummaryRowCard extends StatelessWidget {
  final String title;
  final String value;
  final bool isTotal;

  const SummaryRowCard({
    super.key,
    required this.title,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Text(
          title,
          style: getBoldStyle(
            color: isTotal ? ColorManager.black : ColorManager.darkGray,
            fontSize: isTotal ? 22.sp : 16.sp,
          ),
        ),

        Text(
          value,
          style: getBoldStyle(
            color: isTotal ? ColorManager.primary : ColorManager.black,
            fontSize: isTotal ? 20.sp : 16.sp,
          ),
        ),
      ],
    );
  }
}
