import 'package:chefaa/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/values_manager.dart';

class PaymentTitleCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final bool selected;
  final void Function() onTap;

  const PaymentTitleCard({
    super.key,
    required this.title,
    required this.onTap,
    required this.selected,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppPadding.p14),
        decoration: BoxDecoration(
          color: selected ? ColorManager.input : ColorManager.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            color: selected ? ColorManager.lightBlue : ColorManager.lightGray,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: ColorManager.primary,
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: getBoldStyle(
                      color: ColorManager.black,
                      fontSize: 15.sp,
                    ),
                  ),
                  5.verticalSpace,
                  Text(
                    subtitle,
                    style: getSemiBoldStyle(
                      color: ColorManager.gray,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
