import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Placeholder shown when a section has no data, e.g. "No completed
/// orders today" or "No stock alerts".
class EmptyRow extends StatelessWidget {
  final String text;

  const EmptyRow({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 22.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.lightGray),
      ),
      child: Column(
        children: [
          Icon(Icons.inbox_outlined, color: ColorManager.darkGray, size: 26.sp),
          SizedBox(height: 8.h),
          Text(
            text,
            style: getRegularStyle(color: ColorManager.darkGray, fontSize: 13.sp),
          ),
        ],
      ),
    );
  }
}