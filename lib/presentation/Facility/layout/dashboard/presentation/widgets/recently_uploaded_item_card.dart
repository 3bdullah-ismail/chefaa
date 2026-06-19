import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import '../../data/models/uploaded_result_item.dart';

class RecentlyUploadedItemCard extends StatelessWidget {
  final UploadedResultItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const RecentlyUploadedItemCard({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: AppSize.s12.h),
        padding: EdgeInsets.all(AppPadding.p14.r),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(AppRadius.r16.r),
          border: Border.all(
            color: isSelected
                ? ColorManager.primary.withValues(alpha: 0.6)
                : ColorManager.input.withValues(alpha: 0.6),
            width: isSelected ? 1.5.w : 1.w,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: ColorManager.primary.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: AppSize.s42.r,
              height: AppSize.s42.r,
              decoration: BoxDecoration(
                color: item.iconBgColor,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                item.icon,
                color: item.iconColor,
                size: FontSize.s20.sp,
              ),
            ),
            SizedBox(width: AppSize.s14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: getBoldStyle(
                      color: ColorManager.slate900,
                      fontSize: FontSize.s13.sp,
                    ),
                  ),
                  SizedBox(height: AppSize.s3.h),
                  Text(
                    "${item.scanType} • ${item.time}",
                    style: getMediumStyle(
                      color: ColorManager.gray,
                      fontSize: FontSize.s11.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: AppSize.s8.w),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p10.w,
                vertical: AppPadding.p4.h,
              ),
              decoration: BoxDecoration(
                color: item.statusBgColor,
                borderRadius: BorderRadius.circular(AppRadius.r8.r),
              ),
              child: Text(
                item.status,
                style: getBoldStyle(
                  color: item.statusTextColor,
                  fontSize: FontSize.s9.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
