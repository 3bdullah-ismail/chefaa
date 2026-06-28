import 'package:chefaa/features/patient/cart/presentation/widgets/quantity_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';

class CartItemCard extends StatelessWidget {
  final Map<String, dynamic> item;

  final int index;

  final VoidCallback onIncrease;

  final VoidCallback onDecrease;

  final VoidCallback onDelete;

  const CartItemCard({
    super.key,
    required this.item,
    required this.index,
    required this.onIncrease,
    required this.onDecrease,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p10),

      decoration: BoxDecoration(
        color: ColorManager.lightGray,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    "${item["name"]}   ${item["dosage"]}",
                    style: getBoldStyle(color: Colors.black, fontSize: 17.sp),
                  ),
                  7.verticalSpace,
                  Text(
                    "EGP ${item["price"].toStringAsFixed(2)}\t  per unit",
                    style: getSemiBoldStyle(
                      color: ColorManager.darkGray,
                      fontSize: 16.sp,
                    ),
                  ),

                  15.verticalSpace,
                  Row(
                    children: [
                      QuantityButton(icon: Icons.remove, onTap: onDecrease),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p16,
                        ),
                        child: Text(
                          item["quantity"].toString(),
                          style: getBoldStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),

                      QuantityButton(icon: Icons.add, onTap: onIncrease),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [
              IconButton(
                onPressed: onDelete,

                icon: Icon(
                  Icons.delete_outline_rounded,
                  size: 30.h,
                  color: Colors.redAccent,
                ),
              ),

              const SizedBox(height: 18),

              Text(
                "EGP ${(item["price"] * item["quantity"]).toStringAsFixed(2)}",
                style: getBoldStyle(
                  color: ColorManager.primary,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
