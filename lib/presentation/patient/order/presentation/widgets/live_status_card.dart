import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/values_manager.dart';

class LiveStatusCard extends StatelessWidget {
  const LiveStatusCard({super.key});

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
                "On The Way",
                style: getBoldStyle(color: ColorManager.white, fontSize: 17.sp),
              ),
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
                  "25-35 MINS",
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
            "Your order is out for delivery and moving towards you.",
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
                  color: ColorManager.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: 6,
                width: 200,
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
