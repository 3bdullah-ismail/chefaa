import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';

class ProfileQuickInfoCards extends StatelessWidget {
  final num? rating;
  final num? totalOrders;
  final num? totalMedicines;
  final String? deliveryTime;

  const ProfileQuickInfoCards({
    super.key,
    this.rating,
    this.totalOrders,
    this.totalMedicines,
    this.deliveryTime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildInfoCard(
            title: "Rating",
            value: "${rating ?? 'N/A'}",
            icon: Icons.star_rounded,
            iconColor: Colors.orange.shade400,
            bgColor: Colors.orange.shade50,
          ),
          SizedBox(width: 12.w),
          _buildInfoCard(
            title: "Orders",
            value: "${totalOrders ?? 0}",
            icon: Icons.shopping_bag_rounded,
            iconColor: Colors.blue.shade400,
            bgColor: Colors.blue.shade50,
          ),
          SizedBox(width: 12.w),
          _buildInfoCard(
            title: "Medicines",
            value: "${totalMedicines ?? 0}",
            icon: Icons.medication_rounded,
            iconColor: Colors.green.shade400,
            bgColor: Colors.green.shade50,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 20.sp),
            ),
            SizedBox(height: 12.h),
            Text(
              value,
              style: getBoldStyle(
                color: Colors.black87,
                fontSize: FontSize.s16.sp,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            Text(
              title,
              style: getMediumStyle(
                color: Colors.grey.shade600,
                fontSize: FontSize.s12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
