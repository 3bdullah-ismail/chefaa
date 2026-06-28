import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';

class FilterChipItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterChipItem({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.primary : ColorManager.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? ColorManager.primary : ColorManager.input,
            width: 1.2.w,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: getMediumStyle(
            fontSize: 14.sp,
            color: isSelected ? ColorManager.white : ColorManager.gray,
          ),
        ),
      ),
    );
  }
}
