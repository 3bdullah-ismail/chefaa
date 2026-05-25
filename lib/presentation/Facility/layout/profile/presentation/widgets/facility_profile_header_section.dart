import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FacilityProfileHeaderSection extends StatelessWidget {
  final String title;
  final String location;
  final List<String> chips;
  final VoidCallback onEditPressed;

  const FacilityProfileHeaderSection({
    super.key,
    required this.title,
    required this.location,
    required this.chips,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.medical_services_outlined,
                  color: ColorManager.primary,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: AppSize.s12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: getBoldStyle(
                        color: ColorManager.white,
                        fontSize: FontSize.s18.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: AppSize.s4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: ColorManager.lightBlue,
                          size: 14.sp,
                        ),
                        SizedBox(width: AppSize.s4.w),
                        Expanded(
                          child: Text(
                            location,
                            style: getMediumStyle(
                              color: ColorManager.lightBlue,
                              fontSize: FontSize.s12.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: AppSize.s8.w),
              InkWell(
                onTap: onEditPressed,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.edit_outlined,
                    color: ColorManager.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSize.s16.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 6.h,
            alignment: WrapAlignment.center,
            children: chips.map((chip) => _buildMinimalChip(chip)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMinimalChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: ColorManager.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(AppRadius.r12.r),
        border: Border.all(
          color: ColorManager.white.withValues(alpha: 0.2),
          width: 0.8,
        ),
      ),
      child: Text(
        label,
        style: getMediumStyle(
          color: ColorManager.white,
          fontSize: FontSize.s11.sp,
        ),
      ),
    );
  }
}
