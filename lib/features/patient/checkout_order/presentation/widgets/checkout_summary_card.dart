import 'package:chefaa/features/patient/checkout_order/presentation/widgets/checkout_summary_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';

class CheckoutSummaryCard extends StatelessWidget {
  final double subtotal;
  final double delivery;
  final double total;

  const CheckoutSummaryCard({
    super.key,
    required this.subtotal,
    required this.delivery,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: ColorManager.lightGray,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(80),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          CheckoutSummaryRow(title: "Subtotal", value: subtotal),
          CheckoutSummaryRow(title: "Delivery", value: delivery),
          const Divider(color: ColorManager.lightGray),
          CheckoutSummaryRow(title: "Total", value: total, isTotal: true),
        ],
      ),
    );
  }
}
