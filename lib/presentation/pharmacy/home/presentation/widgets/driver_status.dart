import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/values_manager.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.isAvailable,
    required this.activeOrders,
    required this.color,
  });

  final bool isAvailable;
  final int activeOrders;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: color.withAlpha(100)),
            borderRadius: BorderRadius.circular(20),
            color: color.withAlpha(40),
          ),
          child: Text(
            isAvailable ? 'Available' : 'Busy',
            style: TextStyle(fontSize: 12, color: color),
          ),
        ),
        if (!isAvailable && activeOrders > 0)
          Padding(
            padding: const EdgeInsets.only(top: AppPadding.p8),
            child: Text(
              '$activeOrders active order',
              style: getSemiBoldStyle(color: color, fontSize: 12.sp),
            ),
          ),
      ],
    );
  }
}
