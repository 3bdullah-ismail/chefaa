import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/styles_manager.dart';
import '../../../../../../core/resources/values_manager.dart';

class StateCard extends StatelessWidget {
  final String title;
  final String value;

  const StateCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.input,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.gray.withAlpha(100),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20,
          vertical: AppPadding.p32,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  title,
                  style: getBoldStyle(color: ColorManager.black, fontSize: 16),
                ),
                5.verticalSpace,
                Text(
                  value,
                  style: getBoldStyle(
                    color: ColorManager.darkGray,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  title,
                  style: getBoldStyle(color: ColorManager.black, fontSize: 16),
                ),
                5.verticalSpace,
                Text(
                  value,
                  style: getBoldStyle(
                    color: ColorManager.darkGray,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
