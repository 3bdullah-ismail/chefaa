import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import 'driver_status.dart';

class DriverRow extends StatelessWidget {
  const DriverRow({
    super.key,
    required this.driver,
    required this.statusColor,
    this.onTap,
  });

  final Map<String, dynamic> driver;
  final Color statusColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final name = driver['name'];
    final phone = driver['phone'];
    final vehicle = driver['vehicleLabel'];
    final isAvailable = driver['isAvailable'] ?? true;
    final activeOrders = driver['activeOrders'] ?? 0;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p18,
          vertical: AppPadding.p12,
        ),
        child: Row(
          children: [
            14.horizontalSpace,

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: getBoldStyle(
                      color: ColorManager.primary,
                      fontSize: 14.sp,
                    ),
                  ),
                  5.verticalSpace,
                  Row(
                    children: [
                      const Icon(
                        Icons.delivery_dining_outlined,
                        size: 14,
                        color: ColorManager.h2Color,
                      ),
                      7.horizontalSpace,
                      Text(
                        '$vehicle',
                        style: getSemiBoldStyle(
                          color: ColorManager.h2Color,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                5.verticalSpace,
                  Row(
                    children: [
                      const Icon(
                        Icons.phone,
                        size: 14,
                        color: ColorManager.gray,
                      ),
                      7.horizontalSpace,
                      Text(
                        '$phone',
                        style: getSemiBoldStyle(
                          color: ColorManager.gray,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            StatusBadge(
              isAvailable: isAvailable,
              activeOrders: activeOrders,
              color: statusColor,
            ),
          ],
        ),
      ),
    );
  }
}
