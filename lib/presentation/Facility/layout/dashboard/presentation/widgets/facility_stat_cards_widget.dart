import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';

class FacilityStatCardsWidget extends StatelessWidget {
  const FacilityStatCardsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(
            child: _FacilityStatCardWidget(
              title: "REQUESTS",
              count: "12",
              subtitle: "Today",
            ),
          ),
          SizedBox(width: AppSize.s8.w),
          const Expanded(
            child: _FacilityStatCardWidget(
              title: "COMPLETED",
              count: "8",
              icon: Icons.check_circle_outline_rounded,
              iconColor: ColorManager.lightGreen,
            ),
          ),
          SizedBox(width: AppSize.s8.w),
          const Expanded(
            child: _FacilityStatCardWidget(
              title: "AI MATCHES",
              count: "18",
              icon: Icons.flash_on_rounded,
              iconColor: ColorManager.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _FacilityStatCardWidget extends StatelessWidget {
  final String title;
  final String count;
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;

  const _FacilityStatCardWidget({
    required this.title,
    required this.count,
    this.subtitle,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorManager.input, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.01),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: getBoldStyle(
              color: ColorManager.gray,
              fontSize: FontSize.s10.sp,
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                count,
                style: getBoldStyle(
                  color: ColorManager.black,
                  fontSize: FontSize.s22.sp,
                ),
              ),
              if (subtitle != null) ...[
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    subtitle!,
                    style: getRegularStyle(
                      color: ColorManager.gray,
                      fontSize: FontSize.s10.sp,
                    ),
                  ),
                ),
              ],
              if (icon != null) ...[
                const Spacer(),
                Icon(
                  icon,
                  color: iconColor ?? ColorManager.primary,
                  size: 18.sp,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
