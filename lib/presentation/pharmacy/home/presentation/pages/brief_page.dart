import 'package:chefaa/presentation/pharmacy/home/presentation/widgets/order_and_stock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../widgets/brief_card.dart';
import '../widgets/earning_card.dart';

class BriefTab extends StatelessWidget {
  final double totalCompleted;
  final double netEarnings;
  final int staffAvailable;
  final int staffBusy;
  final int staffTotal;
  final int completed;
  final int pending;
  final int cancelled;
  final int lowStock;

  const BriefTab({
    super.key,
    required this.totalCompleted,
    required this.netEarnings,
    required this.staffAvailable,
    required this.staffBusy,
    required this.staffTotal,
    this.completed = 1,
    this.pending = 5,
    this.cancelled = 2,
    this.lowStock = 3,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.r),
      children: [
        Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "✦ LIVE · Daily Report",
                style: getBoldStyle(
                  color: ColorManager.primary,
                  fontSize: 14.sp,
                ),
              ),
              Text(
                "Monday, June 16, 2026",
                style: getBoldStyle(color: ColorManager.black, fontSize: 15.sp),
              ),
            ],
          ),
        ),

        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 7.h,
          crossAxisSpacing: 7.w,
          childAspectRatio: 1.15,
          children: [
            StatCard(label: 'Completed', value: '$completed'),
            StatCard(label: 'Pending', value: '$pending'),
            StatCard(label: 'Cancelled', value: '$cancelled'),
            StatCard(label: 'Low Stock', value: '$lowStock'),
            StatCard(label: 'Staff', value: '$staffTotal'),
          ],
        ),
        SizedBox(height: 16.h),
        EarningsCard(totalCompleted: totalCompleted, netEarnings: netEarnings),
        SizedBox(height: 20.h),
        const OrdersAndStock(),
      ],
    );
  }
}
