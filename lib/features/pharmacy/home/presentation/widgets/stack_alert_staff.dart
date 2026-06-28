import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StockAlertsStaffCard extends StatelessWidget {
  final List<StockAlertItem> stockAlerts;
  final int staffAvailable;
  final int staffBusy;
  final int staffTotal;

  const StockAlertsStaffCard({
    super.key,
    required this.stockAlerts,
    required this.staffAvailable,
    required this.staffBusy,
    required this.staffTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: ColorManager.lightGray),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(80),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'STOCK ALERTS',
            style: getBoldStyle(color: ColorManager.black, fontSize: 12.sp),
          ),
          SizedBox(height: 6.h),
          Text(
            '${stockAlerts.length} items',
            style: getSemiBoldStyle(
              color: ColorManager.darkGray,
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 10.h),
          ...stockAlerts.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.gold.withAlpha(100),
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: Text(
                        item.name,
                        style: getSemiBoldStyle(
                          color: ColorManager.black,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ),
                  15.horizontalSpace,
                  Text(
                    '${item.left} left',
                    style: getSemiBoldStyle(
                      color: ColorManager.error,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 10.h),

          Text(
            'DELIVERY STAFF',
            style: getBoldStyle(color: ColorManager.black, fontSize: 13.sp),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              _StaffStat(
                label: 'Available\t',
                value: staffAvailable,
                color: ColorManager.lightGreen,
              ),
              SizedBox(width: 10.w),
              _StaffStat(
                label: 'Busy\t',
                value: staffBusy,
                color: ColorManager.darkGray,
              ),
              SizedBox(width: 10.w),
              _StaffStat(
                label: 'Total\t',
                value: staffTotal,
                color: ColorManager.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StaffStat extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _StaffStat({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label ',
            style: getSemiBoldStyle(
              color: ColorManager.darkGray,
              fontSize: 14.sp,
            ),
          ),
          TextSpan(
            text: '$value',
            style: getBoldStyle(color: color, fontSize: 15.sp),
          ),
        ],
      ),
    );
  }
}

class StockAlertItem {
  final String name;
  final int left;

  const StockAlertItem({required this.name, required this.left});
}
