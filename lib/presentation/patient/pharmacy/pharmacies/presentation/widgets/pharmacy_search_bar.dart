import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';

class PharmacySearchBar extends StatelessWidget {
  const PharmacySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      decoration: BoxDecoration(
        color: ColorManager.lightGray,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search medicines or pharmacies',
          hintStyle: getRegularStyle(color: ColorManager.gray, fontSize: 15.sp),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: ColorManager.primary,
            size: 27.h,
          ),
        ),
      ),
    );
  }
}
