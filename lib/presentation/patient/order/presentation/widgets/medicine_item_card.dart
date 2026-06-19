import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/values_manager.dart';

class MedicineItemCard extends StatelessWidget {
  final String name;
  final int quantity;
  final String price;

  const MedicineItemCard({
    super.key,
    required this.name,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p10,
                    vertical: AppPadding.p4,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.lightBlue,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    "${quantity}x",
                    style: getBoldStyle(
                      color: ColorManager.primary,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                15.horizontalSpace,
                Expanded(
                  child: Text(
                    name,
                    style: getBoldStyle(
                      color: ColorManager.black,
                      fontSize: 15.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          Text(
            price,
            style: getBoldStyle(color: ColorManager.darkGray, fontSize: 15.sp),
          ),
        ],
      ),
    );
  }
}
