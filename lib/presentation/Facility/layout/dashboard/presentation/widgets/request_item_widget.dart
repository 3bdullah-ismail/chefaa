import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';

class RequestItemWidget extends StatelessWidget {
  final String name;
  final String scanType;
  final String time;
  final String status;
  final String? aiMatchedText;
  final IconData? aiMatchedIcon;

  const RequestItemWidget({
    super.key,
    required this.name,
    required this.scanType,
    required this.time,
    required this.status,
    this.aiMatchedText,
    this.aiMatchedIcon,
  });

  @override
  Widget build(BuildContext context) {
    final bool isUpcoming = status == "Upcoming";
    final Color statusColor = isUpcoming
        ? const Color(0xFF2563EB)
        : const Color(0xFFD97706);
    final Color statusBg = isUpcoming
        ? const Color(0xFFEFF6FF)
        : const Color(0xFFFEF3C7);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: ColorManager.input.withValues(alpha: 0.6),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 46.r,
            height: 46.r,
            decoration: BoxDecoration(
              color: ColorManager.primary.withValues(alpha: 0.06),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.person_rounded,
              color: ColorManager.primary,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getBoldStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s14.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  scanType,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getMediumStyle(
                    color: ColorManager.gray.withValues(alpha: 0.9),
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 11.sp,
                      color: ColorManager.gray.withValues(alpha: 0.6),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      time,
                      style: getRegularStyle(
                        color: ColorManager.gray.withValues(alpha: 0.7),
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: AppSize.s8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (aiMatchedText != null) ...[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0FDF4),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (aiMatchedIcon != null) ...[
                        Icon(
                          aiMatchedIcon,
                          color: const Color(0xFF16A34A),
                          size: 11.sp,
                        ),
                        SizedBox(width: 3.w),
                      ],
                      Text(
                        aiMatchedText!,
                        style: getBoldStyle(
                          color: const Color(0xFF16A34A),
                          fontSize: 9.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6.h),
              ],
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  status,
                  style: getBoldStyle(
                    color: statusColor,
                    fontSize: FontSize.s10.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
