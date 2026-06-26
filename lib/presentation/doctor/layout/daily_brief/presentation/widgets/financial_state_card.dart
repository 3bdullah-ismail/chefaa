import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/resources/color_manager.dart';
import '../../../../../../../core/resources/styles_manager.dart';

class FinanceStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const FinanceStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: ColorManager.primary,
            size: 24.sp,
          ),
          SizedBox(height: 12.h),
          Text(
            value,
            style: getBoldStyle(
              fontSize: 24.sp,
              color: ColorManager.black,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            title,
            style: getMediumStyle(
              color: ColorManager.gray,
              fontSize: 13.sp,
            ),
          ),
        ],
    );
  }
}