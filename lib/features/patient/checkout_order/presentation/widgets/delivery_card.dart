import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';

class DeliveryCard extends StatelessWidget {
  const DeliveryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: ColorManager.lightGray,
        border: Border.all(color: ColorManager.lightBlue),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: ColorManager.primary,
            child: Icon(
              Icons.local_shipping_rounded,
              color: ColorManager.lightBlue,
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Home Delivery",
                  style: getBoldStyle(
                    color: ColorManager.black,
                    fontSize: 16.sp,
                  ),
                ),
                5.verticalSpace,
                Text(
                  "30 - 60 Minutes .\t\t  20 EGP",
                  style: getBoldStyle(
                    color: ColorManager.gray,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.check_circle, color: ColorManager.primary),
        ],
      ),
    );
  }
}
