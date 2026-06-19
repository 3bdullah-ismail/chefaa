import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';


class ActionButtonCard extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  const ActionButtonCard({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.color = ColorManager.error,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: ColorManager.input.withOpacity(0.6),
          ),
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withAlpha(80),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              width: 18.w,
              height: 18.h,
              colorFilter: const ColorFilter.mode(
                ColorManager.lightGray,
                BlendMode.dstIn,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: getBoldStyle(
                color: color,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}