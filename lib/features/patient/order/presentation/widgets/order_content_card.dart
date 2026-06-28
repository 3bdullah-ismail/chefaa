import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/features/patient/order/data/models/track_order_response.dart';
import 'package:chefaa/features/patient/order/presentation/widgets/medicine_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';

class OrderContentCard extends StatelessWidget {
  final OrderContents contents;

  const OrderContentCard({
    super.key,
    required this.contents,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p20),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(80),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.local_mall_rounded,
                color: ColorManager.primary,
                size: 25.h,
              ),
              10.horizontalSpace,
              Text(
                "Order Contents",
                style: getBoldStyle(color: ColorManager.black, fontSize: 18.sp),
              ),
            ],
          ),
          16.verticalSpace,
          ...contents.items.map((item) => MedicineItemCard(
                name: item.medicineName,
                quantity: item.quantity,
                price: "EGP ${item.price.toStringAsFixed(2)}",
              )),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppPadding.p12),
            child: Divider(color: ColorManager.input, thickness: 0.8),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: getBoldStyle(fontSize: 22.sp, color: ColorManager.black),
              ),
              Text(
                "EGP ${(contents.summary?.totalPrice ?? 0).toStringAsFixed(2)}",
                style: getBoldStyle(
                  fontSize: 20.sp,
                  color: ColorManager.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
