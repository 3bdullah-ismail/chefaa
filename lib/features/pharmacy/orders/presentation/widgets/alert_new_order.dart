import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/core/resources/values_manager.dart';

class NewOrderAlertCard extends StatelessWidget {
  final int count;
  final VoidCallback? onTap;

  const NewOrderAlertCard({super.key, required this.count, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p10,
        ),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: ColorManager.lawAnalysis.withAlpha(50),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.orange.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withAlpha(30),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "New Orders Alert",
                    style: getBoldStyle(
                      color: ColorManager.black,
                      fontSize: 16.sp,
                    ),
                  ),
                  10.verticalSpace,
                  Text(
                    "You have $count new order(s) waiting for processing",
                    style: getRegularStyle(
                      color: ColorManager.gray600,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: ColorManager.lawAnalysis,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                "$count",
                style: getSemiBoldStyle(
                  color: ColorManager.white,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
