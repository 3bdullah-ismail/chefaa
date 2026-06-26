import 'package:chefaa/presentation/pharmacy/home/presentation/widgets/stack_alert_staff.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'completed_order_card.dart';

class OrdersAndStock extends StatelessWidget {
  const OrdersAndStock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CompletedOrdersCard(completedToday: 0, completedTotalOrders: 3),

        SizedBox(height: 12.h),

        const StockAlertsStaffCard(
          stockAlerts: [StockAlertItem(name: 'paracetamol', left: 2)],
          staffAvailable: 4,
          staffBusy: 0,
          staffTotal: 4,
        ),
      ],
    );
  }
}
