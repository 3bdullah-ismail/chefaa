import 'package:chefaa/core/resources/color_manager.dart';
import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:chefaa/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClinicInfoCard extends StatelessWidget {
  final String title;
  final bool isInfinity;
  final String value;

  const ClinicInfoCard({
    super.key,
    this.isInfinity = false,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      width: isInfinity ? double.infinity : null,
      decoration: BoxDecoration(
        color: ColorManager.input,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: ColorManager.input, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p10,
          vertical: AppPadding.p8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: getBoldStyle(color: ColorManager.gray, fontSize: 12),
            ),
            2.verticalSpace,
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: getBoldStyle(color: ColorManager.black, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
