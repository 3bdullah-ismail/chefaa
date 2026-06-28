import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';

class LiveStatusCard extends StatelessWidget {
  final String status;
  final String description;
  final String? time;

  const LiveStatusCard({
    super.key,
    required this.status,
    required this.description,
    this.time,
  });

  double _getProgressWidth(String status) {
    switch (status.toLowerCase()) {
      case 'new':
      case 'confirmed':
        return 80.w;
      case 'preparing':
        return 160.w;
      case 'picked up':
      case 'picked_up':
        return 240.w;
      case 'on the way':
      case 'on_the_way':
      case 'delivered':
        return 320.w;
      default:
        return 80.w;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: ColorManager.primary,
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(80),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                status,
                style: getBoldStyle(color: ColorManager.white, fontSize: 17.sp),
              ),
              if (time != null && time!.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p10,
                    vertical: AppPadding.p4,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.white.withAlpha(130),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Text(
                    time!,
                    style: getBoldStyle(
                      color: ColorManager.white,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: getSemiBoldStyle(
              color: ColorManager.white.withAlpha(200),
              fontSize: 13.sp,
            ),
          ),
          const SizedBox(height: 20),
          Stack(
            children: [
              Container(
                height: 6,
                decoration: BoxDecoration(
                  color: ColorManager.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: 6,
                width: _getProgressWidth(status),
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
