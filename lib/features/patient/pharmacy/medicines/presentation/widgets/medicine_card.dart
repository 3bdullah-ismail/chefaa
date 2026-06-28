import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/resources/color_manager.dart';

class MedicineCard extends StatelessWidget {
  final String name;
  final String description;
  final String price;
  final VoidCallback onAddTap;

  const MedicineCard({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(80),
            blurRadius: 8,
            offset: const Offset(0, 3),
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
                    name,
                    style: getBoldStyle(
                      color: ColorManager.black,
                      fontSize: 17.sp,
                    ),
                  ),
                  7.verticalSpace,
                  Text(
                    description,
                    style: getMediumStyle(
                      color: ColorManager.gray,
                      fontSize: 14.sp,
                    ),
                  ),
                  10.verticalSpace,
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p12,
                      vertical: AppPadding.p6,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.lightBlue.withAlpha(150),
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: Text(
                      price,
                      style: getBoldStyle(
                        color: ColorManager.primary,
                        fontSize: 17.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: onAddTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary.withAlpha(185),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.r),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p16,
                vertical: AppPadding.p10,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.shopping_cart_rounded,
                  size: 16.h,
                  color: ColorManager.white,
                ),
                5.horizontalSpace,
                Text(
                  'Add to Cart',
                  style: getBoldStyle(
                    color: ColorManager.white,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
