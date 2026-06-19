import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';

class ConfirmOrderButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ConfirmOrderButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54.h,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.lightGreen,
          shadowColor: ColorManager.lightGreen.withAlpha(100),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 25.h, color: ColorManager.white),
            10.horizontalSpace,
            Text(
              "Confirm Order Received",
              style: getBoldStyle(color: ColorManager.white, fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );
  }
}
