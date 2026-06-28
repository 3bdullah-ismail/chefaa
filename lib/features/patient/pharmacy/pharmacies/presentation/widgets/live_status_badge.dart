import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';

class LiveStatusBadge extends StatelessWidget {
  final bool isOpen;

  const LiveStatusBadge({super.key, required this.isOpen});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p10,
        vertical: AppPadding.p4,
      ),
      decoration: BoxDecoration(
        color: isOpen ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6.w,
            height: 15.h,
            decoration: BoxDecoration(
              color: isOpen ? ColorManager.lightGreen : ColorManager.error,
              shape: BoxShape.circle,
            ),
          ),
          7.horizontalSpace,
          Text(
            isOpen ? "Open Now" : "Closed",
            style: getBoldStyle(
              color: isOpen ? ColorManager.lightGreen : ColorManager.error,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
