import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/font_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';

class EmptyStateCardWidget extends StatelessWidget {
  final String message;

  const EmptyStateCardWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: AppPadding.p20.h),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppRadius.r16.r),
        border: Border.all(color: ColorManager.input.withValues(alpha: 0.6)),
      ),
      alignment: Alignment.center,
      child: Text(
        message,
        style: getMediumStyle(color: ColorManager.gray, fontSize: FontSize.s12),
      ),
    );
  }
}
