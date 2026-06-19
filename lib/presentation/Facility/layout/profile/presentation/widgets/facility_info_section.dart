import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FacilityInfoSection extends StatelessWidget {
  const FacilityInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppRadius.r16.r),
        border: Border.all(
          color: ColorManager.input.withValues(alpha: 0.8),
          width: 1.w,
        ),
      ),
      child: Column(
        children: [
          const _InfoRow(
            icon: Icons.phone_outlined,
            title: 'Emergency Phone',
            value: '+20 123 456 7890',
          ),
          Divider(
            height: 16.h,
            color: ColorManager.input.withValues(alpha: 0.4),
          ),
          const _InfoRow(
            icon: Icons.access_time_rounded,
            title: 'Working Hours',
            value: '08:00 AM - 11:00 PM',
          ),
          Divider(
            height: 16.h,
            color: ColorManager.input.withValues(alpha: 0.4),
          ),
          const _InfoRow(
            icon: Icons.verified_outlined,
            title: 'License info',
            value: 'MOH Registration #45920-B',
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(AppPadding.p8.r),
            decoration: BoxDecoration(
              color: ColorManager.lightBlue.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppRadius.r10.r),
            ),
            child: Icon(icon, color: ColorManager.primary, size: 20.sp),
          ),
          SizedBox(width: AppSize.s12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: getRegularStyle(
                    color: ColorManager.gray,
                    fontSize: FontSize.s11.sp,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: getBoldStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
