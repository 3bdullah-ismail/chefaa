import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/core/resources/values_manager.dart';

class CustomOutlineBtn extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback? onPressed;

  const CustomOutlineBtn({
    super.key,
    required this.title,
    required this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p10, horizontal: AppPadding.p18),
        side: BorderSide(color: color, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.r),
        ),
      ),
      onPressed: onPressed,
      child: Text(title, style: getMediumStyle(color: color, fontSize: 14.sp)),
    );
  }
}
