import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/presentation/pharmacy/profile/data/models/pharmacy_profile_response.dart';

class OperatingSettingsSection extends StatelessWidget {
  final PharmacyProfileData? profileData;

  const OperatingSettingsSection({super.key, this.profileData});

  @override
  Widget build(BuildContext context) {
    final settings = profileData?.settings;
    final bool isDeliveryAvailable =
        settings?.deliveryAvailable ?? profileData?.deliveryAvailable ?? false;
    final bool isPrescriptionOnly = settings?.prescriptionOnly ?? false;

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
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.policy_rounded,
                  color: Colors.indigo.shade400,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                "Services & Policies",
                style: getBoldStyle(
                  color: Colors.black87,
                  fontSize: FontSize.s16.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: _buildPolicyChip(
                  icon: Icons.local_shipping_rounded,
                  title: "Delivery",
                  subtitle: isDeliveryAvailable ? "Available" : "Unavailable",
                  isActive: isDeliveryAvailable,
                  activeColor: Colors.green.shade500,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildPolicyChip(
                  icon: Icons.description_rounded,
                  title: "Prescription",
                  subtitle: isPrescriptionOnly ? "Required" : "Not Required",
                  isActive: isPrescriptionOnly,
                  activeColor: Colors.orange.shade500,
                  isAlertStyle: isPrescriptionOnly,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyChip({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isActive,
    required Color activeColor,
    bool isAlertStyle = false,
  }) {
    final Color itemColor = isActive
        ? activeColor
        : (isAlertStyle ? Colors.green.shade500 : Colors.grey.shade500);
    final Color bgColor = isActive
        ? activeColor.withValues(alpha: 0.08)
        : (isAlertStyle
              ? Colors.green.shade500.withValues(alpha: 0.08)
              : Colors.grey.shade50);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isActive
              ? activeColor.withValues(alpha: 0.3)
              : Colors.grey.shade200,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: itemColor, size: 24.sp),
          SizedBox(height: 12.h),
          Text(
            title,
            style: getMediumStyle(
              color: Colors.grey.shade600,
              fontSize: FontSize.s13.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: getBoldStyle(
              color: itemColor,
              fontSize: FontSize.s16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
