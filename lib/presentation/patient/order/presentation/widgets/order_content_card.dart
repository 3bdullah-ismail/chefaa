import 'package:chefaa/core/resources/values_manager.dart';
import 'package:chefaa/presentation/patient/order/presentation/widgets/medicine_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/styles_manager.dart';

class OrderContentCard extends StatelessWidget {
  const OrderContentCard({super.key});

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
          const MedicineItemCard(
            name: "Paracetamol 500mg",
            quantity: 2,
            price: "EGP 10.00",
          ),
          const MedicineItemCard(
            name: "Amoxicillin 500mg",
            quantity: 1,
            price: "EGP 15.00",
          ),
          const MedicineItemCard(
            name: "Metformin 500mg",
            quantity: 1,
            price: "EGP 12.50",
          ),

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
                "EGP 52.50",
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
