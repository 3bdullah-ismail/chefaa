import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/features/pharmacy/profile/data/models/pharmacy_profile_response.dart';

class VerificationLicenseSection extends StatelessWidget {
  final PharmacyProfileData? profileData;

  const VerificationLicenseSection({super.key, this.profileData});

  @override
  Widget build(BuildContext context) {
    final reg = profileData?.commercialRegisterNumber ?? "Not Specified";
    final expiry = profileData?.licenseExpiry;
    final status = profileData?.visibilityStatus ?? "active";

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.cyan.shade50,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.verified_user_rounded,
                  color: Colors.cyan.shade600,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                "Verification & License",
                style: getBoldStyle(
                  color: Colors.black87,
                  fontSize: FontSize.s16.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          _buildInfoRow(
            label: "Commercial Register",
            value: reg,
            valueColor: Colors.black87,
          ),
          SizedBox(height: 16.h),
          _buildInfoRow(
            label: "License Expiry",
            value: expiry != null && expiry.isNotEmpty
                ? expiry
                : "Not Specified",
            valueColor: Colors.grey.shade700,
          ),
          SizedBox(height: 16.h),
          _buildInfoRow(
            label: "Account Status",
            value: status.toUpperCase(),
            valueColor: status.toLowerCase() == 'active'
                ? Colors.green.shade700
                : Colors.red.shade700,
            isBadge: true,
            badgeBgColor: status.toLowerCase() == 'active'
                ? Colors.green.shade50
                : Colors.red.shade50,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required String label,
    required String value,
    required Color valueColor,
    bool isBadge = false,
    Color? badgeBgColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: getMediumStyle(
            color: Colors.grey.shade600,
            fontSize: FontSize.s13.sp,
          ),
        ),
        if (isBadge)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: badgeBgColor ?? Colors.grey.shade50,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: valueColor.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Text(
              value,
              style: getSemiBoldStyle(
                color: valueColor,
                fontSize: FontSize.s12.sp,
              ),
            ),
          )
        else
          Text(
            value,
            style: getSemiBoldStyle(
              color: valueColor,
              fontSize: FontSize.s14.sp,
            ),
          ),
      ],
    );
  }
}
