import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/presentation/pharmacy/profile/data/models/pharmacy_profile_response.dart';

class DeliverySection extends StatelessWidget {
  final PharmacyProfileData? profileData;

  const DeliverySection({super.key, this.profileData});

  @override
  Widget build(BuildContext context) {
    final String deliveryTime = profileData?.deliveryTime ?? "Not Specified";

    String areas = "Not Specified";
    if (profileData?.deliveryArea != null &&
        profileData!.deliveryArea!.isNotEmpty) {
      areas = profileData!.deliveryArea!.join(", ");
    }

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
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.local_shipping_rounded,
                  color: Colors.blue.shade400,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                "Delivery Details",
                style: getBoldStyle(
                  color: Colors.black87,
                  fontSize: FontSize.s16.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          _buildDeliveryItem(
            icon: Icons.timer_rounded,
            title: "Delivery Time",
            value: deliveryTime,
            valueColor: ColorManager.primary,
          ),
          SizedBox(height: 16.h),
          _buildDeliveryItem(
            icon: Icons.map_rounded,
            title: "Delivery Areas",
            value: areas,
            valueColor: Colors.black87,
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryItem({
    required IconData icon,
    required String title,
    required String value,
    required Color valueColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20.sp, color: Colors.grey.shade400),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: getMediumStyle(
                  color: Colors.grey.shade600,
                  fontSize: FontSize.s12.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                value,
                style: getSemiBoldStyle(
                  color: valueColor,
                  fontSize: FontSize.s14.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
