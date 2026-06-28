import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/features/pharmacy/profile/data/models/pharmacy_profile_response.dart';

class PaymentMethodsSection extends StatelessWidget {
  final PharmacyProfileData? profileData;

  const PaymentMethodsSection({super.key, this.profileData});

  @override
  Widget build(BuildContext context) {
    final methods = profileData?.paymentMethods;
    final hasMethods = methods != null && methods.isNotEmpty;

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
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.payments_rounded,
                  color: Colors.green.shade400,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                "Accepted Payments",
                style: getBoldStyle(
                  color: Colors.black87,
                  fontSize: FontSize.s16.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          if (hasMethods)
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: methods
                  .map((m) => _buildPaymentChip(m.toString()))
                  .toList(),
            )
          else
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                _buildPaymentChip("Cash on Delivery"),
                _buildPaymentChip("Wallet / Online"),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildPaymentChip(String name) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.green.shade50.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.green.shade200, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle_rounded,
            size: 16.sp,
            color: Colors.green.shade600,
          ),
          SizedBox(width: 8.w),
          Text(
            name,
            style: getMediumStyle(
              color: Colors.green.shade800,
              fontSize: FontSize.s13.sp,
            ),
          ),
        ],
      ),
    );
  }
}
