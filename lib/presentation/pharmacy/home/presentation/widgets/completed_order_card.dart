import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompletedOrdersCard extends StatelessWidget {
  final int completedToday;
  final int completedTotalOrders;

  const CompletedOrdersCard({
    super.key,
    required this.completedToday,
    required this.completedTotalOrders,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'COMPLETED ORDERS',
            style: getBoldStyle(color: ColorManager.black, fontSize: 13.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            '$completedToday today \t\t\t-  \t\t\t$completedTotalOrders orders total',
            style: getSemiBoldStyle(color: ColorManager.darkGray, fontSize: 12.sp),
          ),
         10.verticalSpace,
          if (completedToday == 0)
            Text(
              'No completed orders today',
              style: getBoldStyle(color: ColorManager.darkGray, fontSize: 13.sp)
                  .copyWith(fontStyle: FontStyle.italic),
            ),
        ],
      ),
    );
  }
}