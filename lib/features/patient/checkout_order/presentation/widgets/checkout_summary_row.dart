import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';

class CheckoutSummaryRow extends StatelessWidget {
  final String title;
  final bool isTotal;
  final double value;

  const CheckoutSummaryRow({
    super.key,
    required this.title,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: getBoldStyle(
              color: isTotal ? ColorManager.primary : ColorManager.black,
              fontSize: isTotal ? 22.sp : 16.sp,
            ),
          ),
          Text(
            "EGP ${value.toStringAsFixed(2)}",
            style: getBoldStyle(
              color: isTotal ? ColorManager.black : ColorManager.gray,
              fontSize: isTotal ? 20.sp : 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
