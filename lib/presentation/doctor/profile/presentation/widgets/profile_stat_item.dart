import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileStatItem extends StatelessWidget {
  final String value;
  final String label;
  final Color textColor;
  final Widget? icon;

  const ProfileStatItem({
    super.key,
    required this.value,
    required this.label,
    this.textColor = ColorManager.white,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[icon!, SizedBox(height: 6.h)],
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: getBoldStyle(color: textColor, fontSize: 18.sp),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: getBoldStyle(
            color: textColor.withValues(alpha: 0.6),
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
