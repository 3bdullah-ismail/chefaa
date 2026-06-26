import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';
import '../../../../../../core/resources/values_manager.dart';

class AddToCartButton extends StatelessWidget {
  final String medicineName;

  const AddToCartButton({super.key, required this.medicineName});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
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
            style: getBoldStyle(color: ColorManager.white, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
