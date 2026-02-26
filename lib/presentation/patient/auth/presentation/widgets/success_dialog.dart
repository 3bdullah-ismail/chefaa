import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';

class SuccessDialog extends StatelessWidget {
  final void Function() onPressed;
  const SuccessDialog({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorManager.white,
      icon: SvgPicture.asset(IconsAssets.doneIcon),
      title: Text(
        "Success",
        style: TextStyle(
          color: ColorManager.black,
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: Text(
        "Your account has been successfully registered",
        style: TextStyle(
          color: ColorManager.gray,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onPressed();
          },
          child: Text(
            "Complete Registration",
            style: TextStyle(
              color: ColorManager.primary,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
