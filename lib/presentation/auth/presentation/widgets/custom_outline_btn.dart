import 'package:chefaa/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/resources/color_manager.dart';

class CustomOutlineBtn extends StatelessWidget {
  final String prefixImage;
  final String title;
  final void Function() onPressed;

  const CustomOutlineBtn({
    super.key,
    required this.title,
    required this.onPressed,
    required this.prefixImage,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        onPressed();
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: ColorManager.gray),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.r),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(prefixImage, width: 24, height: 24),
            32.horizontalSpace,
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: ColorManager.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
