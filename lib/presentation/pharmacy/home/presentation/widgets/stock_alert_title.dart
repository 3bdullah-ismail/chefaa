import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Row showing a single stock warning, parsed from a "Name - Status" string,
/// e.g. "Paracetamol - Low Stock" or "Ibuprofen - Out of Stock".
/// "Out of Stock" is shown in red, anything else (e.g. "Low Stock") in orange.
class StockAlertTile extends StatelessWidget {
  final String alert;

  const StockAlertTile({super.key, required this.alert});

  @override
  Widget build(BuildContext context) {
    final parts = alert.split(' - ');
    final name = parts.first.trim();
    final status = parts.length > 1 ? parts[1].trim() : '';
    final isOut = status.toLowerCase().contains('out');
    final severityColor = isOut ? ColorManager.error : ColorManager.gold;

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: severityColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: severityColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: severityColor, size: 18.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              name,
              style: getSemiBoldStyle(
                color: ColorManager.black,
                fontSize: 14.sp,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: severityColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              status,
              style: getSemiBoldStyle(color: severityColor, fontSize: 11.sp),
            ),
          ),
        ],
      ),
    );
  }
}
