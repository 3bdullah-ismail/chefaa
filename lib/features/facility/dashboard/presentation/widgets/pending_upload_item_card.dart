import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/features/facility/dashboard/data/models/pending_upload_item.dart';

class PendingUploadItemCard extends StatelessWidget {
  final PendingUploadItem item;
  final VoidCallback onUpload;

  const PendingUploadItemCard({
    super.key,
    required this.item,
    required this.onUpload,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSize.s12.h),
      padding: EdgeInsets.all(AppPadding.p14.r),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppRadius.r16.r),
        border: Border.all(color: ColorManager.input.withValues(alpha: 0.6)),
      ),
      child: Row(
        children: [
          Container(
            width: AppSize.s44.r,
            height: AppSize.s44.r,
            decoration: BoxDecoration(
              color: item.avatarBgColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              item.initials,
              style: getBoldStyle(
                color: item.avatarTextColor,
                fontSize: FontSize.s14.sp,
              ),
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
                  item.scanType,
                  style: getMediumStyle(
                    color: ColorManager.gray,
                    fontSize: FontSize.s11.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          if (item.isUploading)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: AppSize.s14.r,
                  height: AppSize.s14.r,
                  child: CircularProgressIndicator(
                    strokeWidth: AppSize.s2.w,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      ColorManager.primary,
                    ),
                  ),
                ),
                SizedBox(width: AppSize.s6.w),
                Text(
                  "Uploading",
                  style: getMediumStyle(
                    color: ColorManager.primary,
                    fontSize: 11.sp,
                  ),
                ),
              ],
            )
          else
            SizedBox(
              height: AppSize.s32.h,
              child: ElevatedButton(
                onPressed: onUpload,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.r8.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p14.w),
                ),
                child: Text(
                  "Upload",
                  style: getBoldStyle(
                    color: ColorManager.white,
                    fontSize: FontSize.s11.sp,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
