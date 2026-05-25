import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';

class ServicesSearchBarWidget extends StatelessWidget {
  final TextEditingController controller;

  const ServicesSearchBarWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: ColorManager.input.withValues(alpha: 0.8),
          width: 1.w,
        ),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: "Search services, codes, or department",
          hintStyle: getRegularStyle(
            color: ColorManager.gray,
            fontSize: 13.sp,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: ColorManager.gray,
            size: 20.sp,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
        ),
      ),
    );
  }
}
