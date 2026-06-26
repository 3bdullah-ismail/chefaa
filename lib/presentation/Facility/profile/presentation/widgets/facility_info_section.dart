import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/get_profile_response.dart';

class FacilityInfoSection extends StatelessWidget {
  final ProfileData? profileData;

  const FacilityInfoSection({super.key, this.profileData});

  String _formatWorkingHours(WorkingHours? workingHours) {
    if (workingHours == null ||
        workingHours.open == null ||
        workingHours.close == null) {
      return 'Not Set';
    }
    return '${_formatHour(workingHours.open)} - ${_formatHour(workingHours.close)}';
  }

  String _formatHour(num? hour) {
    if (hour == null) return '--:--';
    final h = hour.toInt();
    final period = h >= 12 ? 'PM' : 'AM';
    var displayHour = h % 12;
    if (displayHour == 0) displayHour = 12;
    final displayHourStr = displayHour.toString().padLeft(2, '0');
    return '$displayHourStr:00 $period';
  }

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
          _InfoRow(
            icon: Icons.phone_outlined,
            title: 'Emergency Phone',
            value: profileData?.phoneNumber ?? '+20 123 456 7890',
          ),
          Divider(
            height: 16.h,
            color: ColorManager.input.withValues(alpha: 0.4),
          ),
          _InfoRow(
            icon: Icons.access_time_rounded,
            title: 'Working Hours',
            value: _formatWorkingHours(profileData?.workingHours),
          ),
          Divider(
            height: 16.h,
            color: ColorManager.input.withValues(alpha: 0.4),
          ),
          _InfoRow(
            icon: Icons.payment_outlined,
            title: 'Payment Methods',
            value: (profileData?.paymentmethod?.isNotEmpty == true)
                ? profileData!.paymentmethod!
                      .map(
                        (e) => e.isEmpty
                            ? ''
                            : '${e[0].toUpperCase()}${e.substring(1)}',
                      )
                      .join(', ')
                : 'Not Set',
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
          Divider(
            height: 16.h,
            color: ColorManager.input.withValues(alpha: 0.4),
          ),
          _InfoRow(
            icon: Icons.local_shipping_outlined,
            title: 'Home Sample Collection',
            value: profileData?.settings?.homeSampleCollection == true
                ? 'Available'
                : 'Not Available',
          ),
          Divider(
            height: 16.h,
            color: ColorManager.input.withValues(alpha: 0.4),
          ),
          _InfoRow(
            icon: Icons.psychology_outlined,
            title: 'AI Recommendations',
            value: profileData?.settings?.aiRecommendations == true
                ? 'Enabled'
                : 'Disabled',
          ),
          Divider(
            height: 16.h,
            color: ColorManager.input.withValues(alpha: 0.4),
          ),
          _InfoRow(
            icon: Icons.health_and_safety_outlined,
            title: 'Insurance Accepted',
            value: profileData?.settings?.insuranceAccepted == true
                ? 'Yes'
                : 'No',
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
