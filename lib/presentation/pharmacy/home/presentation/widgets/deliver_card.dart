import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/values_manager.dart';
import 'driver_raw.dart';

class DriverGroupCard extends StatelessWidget {
  const DriverGroupCard({
    super.key,
    required this.label,
    required this.drivers,
    required this.statusColor,
    this.onDriverTap,
  });

  final String label;

  final List<Map<String, dynamic>> drivers;

  final Color statusColor;
  final void Function(Map<String, dynamic>)? onDriverTap;

  @override
  Widget build(BuildContext context) {
    if (drivers.isEmpty) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color: ColorManager.lightGray,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(60),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHeader(context),

          ...List.generate(drivers.length, (i) {
            final driver = drivers[i];

            return Column(
              children: [
                DriverRow(
                  driver: driver,
                  statusColor: statusColor,
                  onTap: () => onDriverTap?.call(driver),
                ),
                if (i < drivers.length - 1)
                  Divider(
                    color: ColorManager.gray,
                    thickness: 1,
                    height: 1,
                    endIndent: 40.sp,
                    indent: 40.sp,
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p24,
        vertical: AppPadding.p10,
      ),
      child: Row(
        children: [
          Text(
            label.toUpperCase(),
            style: getBoldStyle(color: ColorManager.black),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p8,
              vertical: AppPadding.p2,
            ),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(50),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${drivers.length}',
              style: getBoldStyle(color: statusColor, fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }
}
