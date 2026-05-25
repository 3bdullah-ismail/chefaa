import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';

class FacilityResultsUploadZone extends StatelessWidget {
  final VoidCallback onSelectFile;
  final VoidCallback onCamera;

  const FacilityResultsUploadZone({
    super.key,
    required this.onSelectFile,
    required this.onCamera,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        color: ColorManager.sky200,
        strokeWidth: AppSize.s1.w,
        dashPattern: const [6, 4],
        radius: Radius.circular(AppRadius.r16.r),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: AppPadding.p24.h,
          horizontal: AppPadding.p16.w,
        ),
        decoration: BoxDecoration(
          color: ColorManager.sky50,
          borderRadius: BorderRadius.circular(AppRadius.r16.r),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(AppPadding.p10.r),
              decoration: const BoxDecoration(
                color: ColorManager.blue100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.file_upload_outlined,
                color: ColorManager.primary,
                size: FontSize.s24.sp,
              ),
            ),
            SizedBox(height: AppSize.s12.h),
            Text(
              "Upload result file",
              style: getBoldStyle(
                color: ColorManager.slate900,
                fontSize: FontSize.s14.sp,
              ),
            ),
            SizedBox(height: AppSize.s4.h),
            Text(
              "Support for PDF, JPG or PNG. Max file size\nshould not exceed 10MB.",
              textAlign: TextAlign.center,
              style: getRegularStyle(
                color: ColorManager.gray,
                fontSize: FontSize.s11.sp,
              ),
            ),
            SizedBox(height: AppSize.s16.h),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: AppSize.s38.h,
                    child: ElevatedButton(
                      onPressed: onSelectFile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppRadius.r10.r,
                          ),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        "Select File",
                        style: getBoldStyle(
                          color: ColorManager.white,
                          fontSize: FontSize.s12.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: AppSize.s12.w),
                Expanded(
                  child: SizedBox(
                    height: AppSize.s38.h,
                    child: OutlinedButton(
                      onPressed: onCamera,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: ColorManager.white,
                        side: const BorderSide(
                          color: ColorManager.input,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppRadius.r10.r,
                          ),
                        ),
                      ),
                      child: Text(
                        "Camera",
                        style: getBoldStyle(
                          color: ColorManager.slate900,
                          fontSize: FontSize.s12.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
