import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';

class NextButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isEnabled;

  const NextButton({super.key, required this.onTap, this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnabled ? onTap : null,
      child: Container(
        width: 50.w,
        height: 50.h,
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8, vertical: AppPadding.p8),
        decoration: BoxDecoration(
          color: isEnabled
              ? ColorManager.primary
              : ColorManager.gray.withValues(alpha: .4),
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(
            Icons.arrow_forward_rounded,
            color: ColorManager.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
